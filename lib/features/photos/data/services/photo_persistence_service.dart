import '../dao/photo_dao.dart';
import 'photo_storage_service.dart';

/// File System + SQLite arasında yapılan write işlemlerini koordine eder.
///
/// İki farklı persistence kaynağı tek transaction içine alınamayacağı için
/// gerektiğinde compensation / rollback uygulanır.
final class PhotoPersistenceService {
  PhotoPersistenceService({
    required this._photoDao,
    required this._storageService,
  });

  final PhotoDao _photoDao;
  final PhotoStorageService _storageService;

  /// Dosyayı kalıcı alana taşır ve ardından DB kaydını oluşturur.
  ///
  /// DB insert başarısız olursa oluşturulan fiziksel dosya geri silinir.
  Future<int> savePhoto({required String sourcePath, int? roomId}) async {
    final savedFile = await _storageService.persistFile(sourcePath);

    try {
      return await _photoDao.insertPhoto(
        imagePath: savedFile.path,
        roomId: roomId,
      );
    } catch (error, stackTrace) {
      // DB başarısız oldu:
      // oluşturduğumuz dosyayı geri alıyoruz.
      await _storageService.deleteIfExists(savedFile.path);

      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  /// Önce DB kaydını siler, ardından fiziksel dosyayı temizler.
  ///
  /// DB silme başarısız olursa fiziksel dosyaya hiç dokunulmaz.
  Future<void> deletePhoto({
    required int photoId,
    required String imagePath,
  }) async {
    // Photo DELETE + cleanup queue INSERT aynı SQLite transaction'da.
    final deletedRows = await _photoDao.deletePhotoAndQueueCleanup(
      photoId: photoId,
      imagePath: imagePath,
    );

    if (deletedRows == 0) {
      throw StateError('Silinecek fotoğraf database kaydında bulunamadı.');
    }

    try {
      // Fiziksel dosyayı temizlemeyi hemen deniyoruz.
      await _storageService.deleteIfExists(imagePath);

      // Başarılıysa artık retry gerekmiyor.
      await _photoDao.deletePendingFileCleanupByPath(imagePath);
    } catch (_) {
      // Fiziksel dosya şu anda silinemedi.
      // Cleanup kaydı database'de bırakılır.
      // Daha sonra retryPendingCleanups() tekrar deneyecek.
    }
  }

  Future<void> retryPendingCleanups() async {
    final pendingCleanups = await _photoDao.getPendingFileCleanups();

    for (final cleanup in pendingCleanups) {
      try {
        await _storageService.deleteIfExists(cleanup.filePath);

        await _photoDao.deletePendingFileCleanupById(cleanup.id);
      } catch (_) {
        // Bir dosyanın temizlenememesi diğerlerini engellememeli.
        // Başarısız kayıt DB'de kalır ve sonraki retry'da tekrar denenir.
      }
    }
  }
}
