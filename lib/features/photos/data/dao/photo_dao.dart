import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../buildings/data/buildings_table.dart';
import '../../../floors/data/floors_table.dart';
import '../../../rooms/data/rooms_table.dart';
import '../offline_photos_table.dart';

part 'photo_dao.g.dart';

/// Fotoğraf tablosuyla ilgili bütün veritabanı işlemlerini yöneten DAO.
///
/// Bu sınıfın görevi:
/// - Fotoğrafları veritabanından okumak
/// - Fotoğraf kaydı eklemek
/// - Fotoğraf kaydı silmek
///
/// UI veya Cubit doğrudan Drift sorguları yazmak zorunda kalmaz.
final class PhotoWithLocation {
  final OfflinePhotosTableData photo;
  final RoomsTableData? room;
  final FloorsTableData? floor;
  final BuildingsTableData? building;

  const PhotoWithLocation({
    required this.photo,
    required this.room,
    required this.floor,
    required this.building,
  });
}

@DriftAccessor(
  tables: [OfflinePhotosTable, RoomsTable, FloorsTable, BuildingsTable],
)
class PhotoDao extends DatabaseAccessor<AppDatabase> with _$PhotoDaoMixin {
  /// DAO'nun hangi database üzerinde çalışacağını alıyoruz.
  PhotoDao(super.attachedDatabase);

  /// Tablodaki bütün fotoğraf kayıtlarını getirir.
  ///
  /// SQL karşılığı kabaca:
  /// SELECT * FROM offline_photos_table;
  Future<List<OfflinePhotosTableData>> getAllPhotos() {
    return select(offlinePhotosTable).get();
  }

  /// Fotoğraf tablosunu sürekli izler.
  ///
  /// .watch() bize Stream döndürür.
  /// Tablo değiştiğinde Drift sorguyu tekrar çalıştırır
  /// ve güncel listeyi Stream üzerinden yayınlar.

  Stream<List<OfflinePhotosTableData>> watchAllPhotos() {
    final query = select(offlinePhotosTable)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    return query.watch();
  }

  /// Photo → Room → Floor → Building ilişkisini type-safe JOIN ile izler.
  /// LEFT JOIN, migration öncesindeki atanmamış fotoğrafları da sonuçta tutar.
  Stream<List<PhotoWithLocation>> watchPhotosWithLocation({int? roomId}) {
    final query = select(offlinePhotosTable).join([
      leftOuterJoin(
        roomsTable,
        roomsTable.id.equalsExp(offlinePhotosTable.roomId),
      ),
      leftOuterJoin(floorsTable, floorsTable.id.equalsExp(roomsTable.floorId)),
      leftOuterJoin(
        buildingsTable,
        buildingsTable.id.equalsExp(floorsTable.buildingId),
      ),
    ]);

    if (roomId != null) {
      query.where(offlinePhotosTable.roomId.equals(roomId));
    }
    query.orderBy([OrderingTerm.desc(offlinePhotosTable.createdAt)]);

    return query.watch().map(
      (rows) => rows
          .map(
            (row) => PhotoWithLocation(
              photo: row.readTable(offlinePhotosTable),
              room: row.readTableOrNull(roomsTable),
              floor: row.readTableOrNull(floorsTable),
              building: row.readTableOrNull(buildingsTable),
            ),
          )
          .toList(),
    );
  }

  /// Yeni bir fotoğraf kaydı ekler.
  ///
  /// Fotoğrafın kendisini değil,
  /// cihazdaki kalıcı dosya yolunu database'e kaydediyoruz.
  Future<int> insertPhoto({required String imagePath, int? roomId}) {
    return into(offlinePhotosTable).insert(
      OfflinePhotosTableCompanion.insert(
        imagePath: imagePath,
        roomId: Value(roomId),
      ),
    );
  }

  /// Verilen ID'ye sahip fotoğraf kaydını siler.
  ///
  /// SQL karşılığı kabaca:
  /// DELETE FROM offline_photos_table
  /// WHERE id = ?;
  Future<int> deletePhotoById(int id) {
    return (delete(
      offlinePhotosTable,
    )..where((table) => table.id.equals(id))).go();
  }
}
