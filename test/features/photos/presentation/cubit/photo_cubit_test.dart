import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';

import 'package:driftsql/core/database/app_database.dart';
import 'package:driftsql/features/photos/data/services/photo_persistence_service.dart';
import 'package:driftsql/features/photos/data/services/photo_storage_service.dart';
import 'package:driftsql/features/photos/presentation/cubit/photo_cubit.dart';
import 'package:driftsql/features/photos/presentation/cubit/photo_state.dart';

void main() {
  late AppDatabase database;
  late Directory tempDirectory;

  late PhotoStorageService storageService;
  late PhotoPersistenceService persistenceService;

  late File sourceFile;
  late String pickedPath;

  late PhotoCubit cubit;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());

    tempDirectory = await Directory.systemTemp.createTemp('photo_cubit_test_');

    sourceFile = File(
      '${tempDirectory.path}${Platform.pathSeparator}source.jpg',
    );

    await sourceFile.writeAsBytes([1, 2, 3, 4]);

    pickedPath = sourceFile.path;

    storageService = PhotoStorageService(
      directoryProvider: () async => tempDirectory,
      fileNameGenerator: (_) => 'saved_photo.jpg',
    );

    persistenceService = PhotoPersistenceService(
      photoDao: database.photoDao,
      storageService: storageService,
    );

    cubit = PhotoCubit(
      database.photoDao,
      persistenceService: persistenceService,
      picker: (_) async => XFile(pickedPath),
    );
  });

  tearDown(() async {
    await cubit.close();
    await database.close();

    if (await tempDirectory.exists()) {
      await tempDirectory.delete(recursive: true);
    }
  });

  test('successful save refreshes list after persistence mutation', () async {
    await cubit.loadInitialPage();

    expect(cubit.state, isA<PhotoLoaded>());

    var state = cubit.state as PhotoLoaded;

    expect(state.photos, isEmpty);

    await cubit.pickAndSavePhoto(ImageSource.gallery);

    expect(cubit.state, isA<PhotoLoaded>());

    state = cubit.state as PhotoLoaded;

    expect(state.photos, hasLength(1));

    final databasePhotos = await database.photoDao.getAllPhotos();

    expect(databasePhotos, hasLength(1));
  });

  test('successful delete refreshes list after persistence mutation', () async {
    await cubit.loadInitialPage();

    await cubit.pickAndSavePhoto(ImageSource.gallery);

    var state = cubit.state as PhotoLoaded;

    expect(state.photos, hasLength(1));

    final photo = state.photos.single;

    await cubit.deletePhoto(photo);

    expect(cubit.state, isA<PhotoLoaded>());

    state = cubit.state as PhotoLoaded;

    expect(state.photos, isEmpty);
    expect(await database.photoDao.getAllPhotos(), isEmpty);
  });

  test('save failure preserves already loaded photos', () async {
    await cubit.loadInitialPage();

    await cubit.pickAndSavePhoto(ImageSource.gallery);

    var state = cubit.state as PhotoLoaded;

    expect(state.photos, hasLength(1));

    pickedPath =
        '${tempDirectory.path}'
        '${Platform.pathSeparator}'
        'missing.jpg';

    await cubit.pickAndSavePhoto(ImageSource.gallery);

    expect(cubit.state, isA<PhotoLoaded>());

    state = cubit.state as PhotoLoaded;

    expect(state.photos, hasLength(1));
    expect(state.operationError, isNotNull);

    cubit.clearOperationError();

    state = cubit.state as PhotoLoaded;

    expect(state.photos, hasLength(1));
    expect(state.operationError, isNull);
  });

  test('delete failure preserves already loaded photos', () async {
    await cubit.loadInitialPage();

    await cubit.pickAndSavePhoto(ImageSource.gallery);

    var state = cubit.state as PhotoLoaded;

    final photo = state.photos.single;

    // Persistence service'in artık bulamayacağı bir kayıt oluşturuyoruz.
    await database.photoDao.deletePhotoById(photo.photo.id);

    await cubit.deletePhoto(photo);

    expect(cubit.state, isA<PhotoLoaded>());

    state = cubit.state as PhotoLoaded;

    expect(state.photos, hasLength(1));
    expect(state.operationError, contains('Fotoğraf silinirken'));
  });
}
