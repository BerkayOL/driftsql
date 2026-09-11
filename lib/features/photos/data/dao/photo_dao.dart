import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

import '../models/photo_page.dart';

import '../../../buildings/data/buildings_table.dart';
import '../../../buildings/data/buildings_table.drift.dart';

import '../../../floors/data/floors_table.dart';
import '../../../floors/data/floors_table.drift.dart';

import '../../../rooms/data/rooms_table.dart';
import '../../../rooms/data/rooms_table.drift.dart';

import '../offline_photos_table.dart';
import '../offline_photos_table.drift.dart';

import '../pending_file_cleanup_table.dart';
import '../pending_file_cleanup_table.drift.dart';

import 'photo_dao.drift.dart';

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
  tables: [
    OfflinePhotosTable,
    RoomsTable,
    FloorsTable,
    BuildingsTable,
    PendingFileCleanupTable,
  ],
)
class PhotoDao extends DatabaseAccessor<AppDatabase> with $PhotoDaoMixin {
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

  /// Fotoğraf kaydını siler ve DB'de saklanan dosya yolu için cleanup
  /// işini aynı SQLite transaction içerisinde oluşturur.
  ///
  /// Kayıt bulunamazsa null, silinen kaydın gerçek dosya yolunu aksi halde
  /// döndürür. Böylece caller bağımsız ve hatalı bir yol sağlayamaz.
  Future<String?> deletePhotoAndQueueCleanup(int photoId) {
    return transaction(() async {
      final photo = await (select(
        offlinePhotosTable,
      )..where((table) => table.id.equals(photoId))).getSingleOrNull();

      if (photo == null) {
        return null;
      }

      final deletedRows = await (delete(
        offlinePhotosTable,
      )..where((table) => table.id.equals(photoId))).go();

      if (deletedRows == 0) {
        return null;
      }

      await into(pendingFileCleanupTable).insert(
        PendingFileCleanupTableCompanion.insert(filePath: photo.imagePath),
        mode: InsertMode.insertOrIgnore,
      );

      return photo.imagePath;
    });
  }

  /// Bekleyen fiziksel dosya cleanup işlerini getirir.
  Future<List<PendingFileCleanupTableData>> getPendingFileCleanups() {
    return select(pendingFileCleanupTable).get();
  }

  /// Başarıyla tamamlanan cleanup işini kuyruktan kaldırır.
  Future<int> deletePendingFileCleanupById(int id) {
    return (delete(
      pendingFileCleanupTable,
    )..where((table) => table.id.equals(id))).go();
  }

  Future<int> deletePendingFileCleanupByPath(String filePath) {
    return (delete(
      pendingFileCleanupTable,
    )..where((table) => table.filePath.equals(filePath))).go();
  }

  Future<PhotoPage> getPhotosPage({
    int? roomId,
    PhotoCursor? cursor,
    int pageSize = 30,
  }) async {
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

    if (cursor != null) {
      query.where(
        offlinePhotosTable.createdAt.isSmallerThanValue(cursor.createdAt) |
            (offlinePhotosTable.createdAt.equals(cursor.createdAt) &
                offlinePhotosTable.id.isSmallerThanValue(cursor.id)),
      );
    }

    query.orderBy([
      OrderingTerm.desc(offlinePhotosTable.createdAt),
      OrderingTerm.desc(offlinePhotosTable.id),
    ]);

    // Bir fazla kayıt çekiyoruz.
    // Böylece gerçekten devam eden başka sayfa var mı anlayabiliyoruz.
    query.limit(pageSize + 1);

    final rows = await query.get();

    final hasMore = rows.length > pageSize;

    final visibleRows = hasMore ? rows.take(pageSize).toList() : rows;

    final items = visibleRows
        .map(
          (row) => PhotoWithLocation(
            photo: row.readTable(offlinePhotosTable),
            room: row.readTableOrNull(roomsTable),
            floor: row.readTableOrNull(floorsTable),
            building: row.readTableOrNull(buildingsTable),
          ),
        )
        .toList();

    final lastPhoto = items.isEmpty ? null : items.last.photo;

    return PhotoPage(
      items: items,
      hasMore: hasMore,
      nextCursor: lastPhoto == null
          ? null
          : PhotoCursor(createdAt: lastPhoto.createdAt, id: lastPhoto.id),
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
