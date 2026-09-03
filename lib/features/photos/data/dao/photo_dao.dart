import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
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
@DriftAccessor(tables: [OfflinePhotosTable])
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

  /// Yeni bir fotoğraf kaydı ekler.
  ///
  /// Fotoğrafın kendisini değil,
  /// cihazdaki kalıcı dosya yolunu database'e kaydediyoruz.
  Future<int> insertPhoto({required String imagePath}) {
    return into(
      offlinePhotosTable,
    ).insert(OfflinePhotosTableCompanion.insert(imagePath: imagePath));
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
