import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../buildings/data/buildings_table.dart';
import '../../../rooms/data/rooms_table.dart';
import '../floors_table.dart';

part 'floor_dao.g.dart';

/// JOIN sonucundaki kat ve bağlı olduğu bina bilgisini type-safe taşır.
final class FloorWithBuilding {
  final FloorsTableData floor;
  final String buildingName;

  const FloorWithBuilding({required this.floor, required this.buildingName});
}

/// Katlarla ilgili bütün local database işlemlerini yöneten DAO.
///
/// UI ve Cubit Drift sorgularını bilmez; yalnızca bu metotları kullanır.
@DriftAccessor(tables: [FloorsTable, BuildingsTable, RoomsTable])
class FloorDao extends DatabaseAccessor<AppDatabase> with _$FloorDaoMixin {
  FloorDao(super.attachedDatabase);

  /// Bir binaya ait katları reactive olarak izler.
  ///
  /// `.watch()` sayesinde o binaya kat eklendiğinde veya kat silindiğinde
  /// güncel liste yeniden sorgulanıp Stream üzerinden yayınlanır.
  Stream<List<FloorsTableData>> watchFloorsByBuilding(int buildingId) {
    final query = select(floorsTable)
      ..where((table) => table.buildingId.equals(buildingId))
      ..orderBy([(table) => OrderingTerm.asc(table.floorNumber)]);

    return query.watch();
  }

  /// Katları, foreign key ile bağlı oldukları binanın adıyla birlikte getirir.
  ///
  /// INNER JOIN yalnızca geçerli bir binaya bağlı katları döndürür.
  /// Sorgu reactive olduğu için kat veya bina adı değişirse sonuç yenilenir.
  Stream<List<FloorWithBuilding>> watchFloorsWithBuilding(int buildingId) {
    final query =
        select(floorsTable).join([
            innerJoin(
              buildingsTable,
              buildingsTable.id.equalsExp(floorsTable.buildingId),
            ),
          ])
          ..where(floorsTable.buildingId.equals(buildingId))
          ..orderBy([OrderingTerm.asc(floorsTable.floorNumber)]);

    return query.watch().map(
      (rows) => rows
          .map(
            (row) => FloorWithBuilding(
              floor: row.readTable(floorsTable),
              buildingName: row.readTable(buildingsTable).name,
            ),
          )
          .toList(),
    );
  }

  /// buildingId alanı, BuildingsTable.id alanına bağlı foreign key'dir.
  /// Bu nedenle var olmayan bir binaya kat eklenmesini SQLite engeller.
  Future<int> insertFloor({
    required int buildingId,
    required String name,
    required int floorNumber,
  }) {
    return into(floorsTable).insert(
      FloorsTableCompanion.insert(
        buildingId: buildingId,
        name: name,
        floorNumber: floorNumber,
      ),
    );
  }

  Future<int> deleteFloorById(int id) {
    return (delete(floorsTable)..where((table) => table.id.equals(id))).go();
  }

  /// Kat ve ilk odası ya birlikte oluşur ya da hata halinde ikisi de geri alınır.
  Future<int> insertFloorWithFirstRoom({
    required int buildingId,
    required String floorName,
    required int floorNumber,
    required String roomName,
    required double roomArea,
  }) {
    return transaction(() async {
      final floorId = await into(floorsTable).insert(
        FloorsTableCompanion.insert(
          buildingId: buildingId,
          name: floorName,
          floorNumber: floorNumber,
        ),
      );
      await into(roomsTable).insert(
        RoomsTableCompanion.insert(
          floorId: floorId,
          name: roomName,
          area: roomArea,
        ),
      );
      return floorId;
    });
  }
}
