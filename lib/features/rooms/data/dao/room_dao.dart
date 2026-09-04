import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../buildings/data/buildings_table.dart';
import '../../../floors/data/floors_table.dart';
import '../rooms_table.dart';

part 'room_dao.g.dart';

/// JOIN sonucunda Room + Floor + Building bilgilerini
/// type-safe şekilde tek nesnede taşımamızı sağlar.
///
/// Bu bir database tablosu değildir.
/// Sadece sorgu sonucunu uygulama içerisinde taşımak için
/// oluşturduğumuz result modelidir.
class RoomWithLocation {
  final RoomsTableData room;
  final FloorsTableData floor;
  final BuildingsTableData building;

  const RoomWithLocation({
    required this.room,
    required this.floor,
    required this.building,
  });
}

final class RoomReport {
  final int roomCount;
  final double totalArea;
  final double? averageTargetTemperature;

  const RoomReport({
    required this.roomCount,
    required this.totalArea,
    required this.averageTargetTemperature,
  });
}

/// Odalarla ilgili local database işlemlerini yöneten DAO.
///
/// RoomDao:
/// - Oda ekler
/// - Oda siler
/// - Bir kata ait odaları reactive olarak izler
/// - Room + Floor + Building JOIN sorgusunu çalıştırır
@DriftAccessor(tables: [RoomsTable, FloorsTable, BuildingsTable])
class RoomDao extends DatabaseAccessor<AppDatabase> with _$RoomDaoMixin {
  RoomDao(super.attachedDatabase);

  /// Belirli bir kata ait odaları reactive olarak izler.
  ///
  /// SQL karşılığı:
  ///
  /// SELECT *
  /// FROM rooms_table
  /// WHERE floor_id = ?
  /// ORDER BY name ASC;
  Stream<List<RoomsTableData>> watchRoomsByFloor(int floorId) {
    final query = select(roomsTable)
      ..where((room) => room.floorId.equals(floorId))
      ..orderBy([(room) => OrderingTerm.asc(room.name)]);

    return query.watch();
  }

  /// Yeni oda oluşturur.
  ///
  /// floorId sayesinde oda doğrudan bir Floor'a bağlanır.
  Future<int> insertRoom({
    required int floorId,
    required String name,
    required bool isHeated,
    required double? targetTemperature,
    required double area,
  }) {
    return into(roomsTable).insert(
      RoomsTableCompanion.insert(
        floorId: floorId,
        name: name,
        isHeated: Value(isHeated),
        targetTemperature: Value(targetTemperature),
        area: area,
      ),
    );
  }

  /// ID'si verilen odayı siler.
  Future<int> deleteRoomById(int id) {
    return (delete(roomsTable)..where((room) => room.id.equals(id))).go();
  }

  /// Room + Floor + Building tablolarını JOIN ile birleştirir.
  ///
  /// Böylece Room kaydının içinde buildingId tutmamıza gerek
  /// kalmadan odanın hangi binaya ait olduğunu bulabiliriz.
  Stream<List<RoomWithLocation>> watchRoomsWithLocation({int? floorId}) {
    final query = select(roomsTable).join([
      /// Room.floorId = Floor.id
      innerJoin(floorsTable, floorsTable.id.equalsExp(roomsTable.floorId)),

      /// Floor.buildingId = Building.id
      innerJoin(
        buildingsTable,
        buildingsTable.id.equalsExp(floorsTable.buildingId),
      ),
    ]);

    if (floorId != null) {
      query.where(roomsTable.floorId.equals(floorId));
    }

    /// JOIN sorguları doğrudan tek bir table data class dönmez.
    ///
    /// Drift her satırı TypedResult olarak verir.
    /// readTable() ile o satırdaki Room, Floor ve Building
    /// nesnelerini type-safe şekilde okuyoruz.
    return query.watch().map((rows) {
      return rows.map((row) {
        return RoomWithLocation(
          room: row.readTable(roomsTable),
          floor: row.readTable(floorsTable),
          building: row.readTable(buildingsTable),
        );
      }).toList();
    });
  }

  /// Ülke + yapım yılı + ısıtma durumunu üç tablo üzerinde filtreler.
  Stream<List<RoomWithLocation>> watchHeatedRoomsByBuildingCriteria({
    required String countryCode,
    required int builtBefore,
  }) {
    final query =
        select(roomsTable).join([
            innerJoin(
              floorsTable,
              floorsTable.id.equalsExp(roomsTable.floorId),
            ),
            innerJoin(
              buildingsTable,
              buildingsTable.id.equalsExp(floorsTable.buildingId),
            ),
          ])
          ..where(
            roomsTable.isHeated.equals(true) &
                buildingsTable.countryCode.equals(countryCode) &
                buildingsTable.constructionYear.isSmallerThanValue(builtBefore),
          )
          ..orderBy([OrderingTerm.asc(roomsTable.name)]);

    return query.watch().map(
      (rows) => rows
          .map(
            (row) => RoomWithLocation(
              room: row.readTable(roomsTable),
              floor: row.readTable(floorsTable),
              building: row.readTable(buildingsTable),
            ),
          )
          .toList(),
    );
  }

  /// COUNT / SUM / AVG ifadelerini SQLite içinde hesaplayan reactive rapor.
  Stream<RoomReport> watchRoomReport() {
    final roomCount = roomsTable.id.count();
    final totalArea = roomsTable.area.sum();
    final averageTemperature = roomsTable.targetTemperature.avg();
    final query = selectOnly(roomsTable)
      ..addColumns([roomCount, totalArea, averageTemperature]);

    return query.watchSingle().map(
      (row) => RoomReport(
        roomCount: row.read(roomCount) ?? 0,
        totalArea: row.read(totalArea) ?? 0,
        averageTargetTemperature: row.read(averageTemperature),
      ),
    );
  }
}
