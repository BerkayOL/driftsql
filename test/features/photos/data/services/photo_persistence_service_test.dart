import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:driftsql/core/database/app_database.dart';
import 'package:driftsql/features/photos/data/dao/photo_dao.dart';
import 'package:driftsql/features/photos/data/services/photo_persistence_service.dart';
import 'package:driftsql/features/photos/data/services/photo_storage_service.dart';

final class TestPhotoDao extends PhotoDao {
  TestPhotoDao(super.attachedDatabase);

  bool failInsert = false;
  bool failDelete = false;

  @override
  Future<int> insertPhoto({required String imagePath, int? roomId}) {
    if (failInsert) {
      return Future<int>.error(StateError('Test insert failure'));
    }

    return super.insertPhoto(imagePath: imagePath, roomId: roomId);
  }

  @override
  Future<String?> deletePhotoAndQueueCleanup(int photoId) {
    if (failDelete) {
      return Future<String?>.error(StateError('Test delete failure'));
    }

    return super.deletePhotoAndQueueCleanup(photoId);
  }
}

void main() {
  late AppDatabase database;
  late TestPhotoDao photoDao;

  late Directory tempDirectory;
  late PhotoStorageService storageService;
  late PhotoPersistenceService persistenceService;

  late bool failFileDelete;
  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    photoDao = TestPhotoDao(database);
    failFileDelete = false;
    tempDirectory = await Directory.systemTemp.createTemp(
      'photo_persistence_test_',
    );

    storageService = PhotoStorageService(
      directoryProvider: () async => tempDirectory,
      fileNameGenerator: (_) => 'saved_photo.jpg',
      fileDeleter: (filePath) async {
        if (failFileDelete) {
          throw FileSystemException('Test file delete failure', filePath);
        }

        final file = File(filePath);

        if (await file.exists()) {
          await file.delete();
        }
      },
    );

    persistenceService = PhotoPersistenceService(
      photoDao: photoDao,
      storageService: storageService,
    );
  });

  tearDown(() async {
    await database.close();

    if (await tempDirectory.exists()) {
      await tempDirectory.delete(recursive: true);
    }
  });

  test(
    'successful save creates both physical file and database record',
    () async {
      final sourceFile = File(
        '${tempDirectory.path}${Platform.pathSeparator}source.jpg',
      );

      await sourceFile.writeAsBytes([1, 2, 3, 4]);

      await persistenceService.savePhoto(sourcePath: sourceFile.path);

      final savedFile = File(
        '${tempDirectory.path}'
        '${Platform.pathSeparator}offline_photos'
        '${Platform.pathSeparator}saved_photo.jpg',
      );

      expect(await savedFile.exists(), isTrue);

      final photos = await photoDao.getAllPhotos();

      expect(photos, hasLength(1));
      expect(photos.single.imagePath, savedFile.path);
    },
  );

  test(
    'database insert failure removes already copied physical file',
    () async {
      final sourceFile = File(
        '${tempDirectory.path}${Platform.pathSeparator}source.jpg',
      );

      await sourceFile.writeAsBytes([1, 2, 3, 4]);

      photoDao.failInsert = true;

      await expectLater(
        persistenceService.savePhoto(sourcePath: sourceFile.path),
        throwsA(anything),
      );

      final savedFile = File(
        '${tempDirectory.path}'
        '${Platform.pathSeparator}offline_photos'
        '${Platform.pathSeparator}saved_photo.jpg',
      );

      expect(await savedFile.exists(), isFalse);

      final photos = await photoDao.getAllPhotos();

      expect(photos, isEmpty);

      // Kaynak dosya bizim olmadığı için silinmemeli.
      expect(await sourceFile.exists(), isTrue);
    },
  );

  test('database delete failure keeps physical file untouched', () async {
    final sourceFile = File(
      '${tempDirectory.path}${Platform.pathSeparator}source.jpg',
    );

    await sourceFile.writeAsBytes([1, 2, 3, 4]);

    final photoId = await persistenceService.savePhoto(
      sourcePath: sourceFile.path,
    );

    final photosBeforeDelete = await photoDao.getAllPhotos();

    expect(photosBeforeDelete, hasLength(1));

    final savedPath = photosBeforeDelete.single.imagePath;
    final savedFile = File(savedPath);

    expect(await savedFile.exists(), isTrue);

    photoDao.failDelete = true;

    await expectLater(
      persistenceService.deletePhoto(photoId),
      throwsA(anything),
    );

    expect(await savedFile.exists(), isTrue);

    final photosAfterDelete = await photoDao.getAllPhotos();

    expect(photosAfterDelete, hasLength(1));
    expect(photosAfterDelete.single.id, photoId);
  });

  test(
    'successful delete removes both database record and physical file',
    () async {
      final sourceFile = File(
        '${tempDirectory.path}${Platform.pathSeparator}source.jpg',
      );

      await sourceFile.writeAsBytes([1, 2, 3, 4]);

      final photoId = await persistenceService.savePhoto(
        sourcePath: sourceFile.path,
      );

      final photos = await photoDao.getAllPhotos();

      final savedPath = photos.single.imagePath;
      final savedFile = File(savedPath);

      await persistenceService.deletePhoto(photoId);

      expect(await savedFile.exists(), isFalse);
      expect(await photoDao.getAllPhotos(), isEmpty);
    },
  );
  test('file delete failure leaves persistent cleanup queued', () async {
    final sourceFile = File(
      '${tempDirectory.path}${Platform.pathSeparator}source.jpg',
    );

    await sourceFile.writeAsBytes([1, 2, 3, 4]);

    final photoId = await persistenceService.savePhoto(
      sourcePath: sourceFile.path,
    );

    final photos = await photoDao.getAllPhotos();
    final savedPath = photos.single.imagePath;
    final savedFile = File(savedPath);

    failFileDelete = true;

    await persistenceService.deletePhoto(photoId);

    // Mantıksal DB kaydı silinmiş olmalı.
    expect(await photoDao.getAllPhotos(), isEmpty);

    // Fiziksel delete başarısız olduğu için dosya hâlâ durur.
    expect(await savedFile.exists(), isTrue);

    // Ama cleanup görevi kaybolmamalı.
    final pendingCleanups = await photoDao.getPendingFileCleanups();

    expect(pendingCleanups, hasLength(1));
    expect(pendingCleanups.single.filePath, savedPath);
  });
  test('retry removes orphan file and clears pending cleanup', () async {
    final sourceFile = File(
      '${tempDirectory.path}${Platform.pathSeparator}source.jpg',
    );

    await sourceFile.writeAsBytes([1, 2, 3, 4]);

    final photoId = await persistenceService.savePhoto(
      sourcePath: sourceFile.path,
    );

    final photos = await photoDao.getAllPhotos();
    final savedPath = photos.single.imagePath;
    final savedFile = File(savedPath);

    // İlk fiziksel delete'i bilerek bozuyoruz.
    failFileDelete = true;

    await persistenceService.deletePhoto(photoId);

    expect(await savedFile.exists(), isTrue);
    expect(await photoDao.getPendingFileCleanups(), hasLength(1));

    // Dosya sistemi tekrar kullanılabilir hale geldi.
    failFileDelete = false;

    // Yeni bir service instance bile queue'yu DB'den okuyabilir.
    final retryService = PhotoPersistenceService(
      photoDao: photoDao,
      storageService: storageService,
    );

    await retryService.retryPendingCleanups();

    expect(await savedFile.exists(), isFalse);
    expect(await photoDao.getPendingFileCleanups(), isEmpty);
  });

  test('nonexistent photo ID does not touch files or queue cleanup', () async {
    final unrelatedFile = File(
      '${tempDirectory.path}${Platform.pathSeparator}unrelated.jpg',
    );
    await unrelatedFile.writeAsBytes([1, 2, 3, 4]);

    await expectLater(
      persistenceService.deletePhoto(999),
      throwsA(isA<StateError>()),
    );

    expect(await unrelatedFile.exists(), isTrue);
    expect(await photoDao.getPendingFileCleanups(), isEmpty);
  });

  test('delete uses the path stored on the selected database row', () async {
    final firstFile = File(
      '${tempDirectory.path}${Platform.pathSeparator}first.jpg',
    );
    final secondFile = File(
      '${tempDirectory.path}${Platform.pathSeparator}second.jpg',
    );
    await firstFile.writeAsBytes([1]);
    await secondFile.writeAsBytes([2]);

    final firstId = await photoDao.insertPhoto(imagePath: firstFile.path);
    final secondId = await photoDao.insertPhoto(imagePath: secondFile.path);

    await persistenceService.deletePhoto(firstId);

    expect(await firstFile.exists(), isFalse);
    expect(await secondFile.exists(), isTrue);

    final remainingPhotos = await photoDao.getAllPhotos();
    expect(remainingPhotos, hasLength(1));
    expect(remainingPhotos.single.id, secondId);
    expect(remainingPhotos.single.imagePath, secondFile.path);
    expect(await photoDao.getPendingFileCleanups(), isEmpty);
  });
}
