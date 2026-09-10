import 'dart:async';

import 'package:driftsql/features/photos/data/dao/photo_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/services/photo_persistence_service.dart';
import '../../data/services/photo_storage_service.dart';

import 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  /// Fotoğraf database işlemleri DAO tarafından yönetilir.
  final PhotoDao _photoDao;

  /// Kamera veya galeriyi açmak için kullanılır.
  final ImagePicker _picker = ImagePicker();

  /// File System + SQLite arasında yapılan write işlemlerini koordine eder.
  final PhotoPersistenceService _photoPersistenceService;

  /// Drift'in gönderdiği fotoğraf listesini dinlemek için kullanılır.
  ///
  /// Bu subscription sayesinde Cubit,
  /// database değişikliklerini sürekli takip edebilir.
  StreamSubscription<List<PhotoWithLocation>>? _photosSubscription;

  /// Cubit oluşturulurken DAO ve opsiyonel olarak persistence service verilir.
  /// Eğer persistence service verilmezse Cubit kendi default instance'ını oluşturur.
  PhotoCubit(PhotoDao photoDao, {PhotoPersistenceService? persistenceService})
    : _photoDao = photoDao,
      _photoPersistenceService =
          persistenceService ??
          PhotoPersistenceService(
            photoDao: photoDao,
            storageService: PhotoStorageService(),
          ),
      super(PhotoInitial());

  /// Fotoğraf tablosunu reactive olarak izlemeye başlar.
  ///
  /// Eskiden:
  /// getAllPhotos() ile veriyi bir kere çekiyorduk.
  ///
  /// Şimdi:
  /// watchAllPhotos() ile tabloyu sürekli izliyoruz.
  Future<void> watchPhotos({int? roomId}) async {
    emit(PhotoLoading());

    await _photoPersistenceService.retryPendingCleanups();

    // Bu metod birden fazla kez çağrılırsa
    // eski dinleyiciyi kapatıp yenisini oluşturuyoruz.
    await _photosSubscription?.cancel();

    _photosSubscription = _photoDao
        .watchPhotosWithLocation(roomId: roomId)
        .listen(
          (photos) {
            // Database değiştiğinde Drift bize yeni listeyi gönderir.
            if (!isClosed) {
              emit(PhotoLoaded(photos));
            }
          },
          onError: (Object error, StackTrace stackTrace) {
            if (!isClosed) {
              emit(
                PhotoError('Fotoğraflar izlenirken bir hata oluştu: $error'),
              );
            }
          },
        );
  }

  /// Kamera veya galeriden fotoğraf alır,
  /// kalıcı dosya alanına kaydeder
  /// ve database'e local path bilgisini ekler.
  Future<void> pickAndSavePhoto(ImageSource source, {int? roomId}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile == null) return;

      emit(PhotoLoading());

      await _photoPersistenceService.savePhoto(
        sourcePath: pickedFile.path,
        roomId: roomId,
      );
    } catch (e) {
      if (!isClosed) {
        emit(PhotoError('Fotoğraf kaydedilirken bir hata oluştu: $e'));
      }
    }
  }

  /// Fotoğrafın fiziksel dosyasını
  /// ve database kaydını siler.
  Future<void> deletePhoto(PhotoWithLocation result) async {
    try {
      final photo = result.photo;

      await _photoPersistenceService.deletePhoto(
        photoId: photo.id,
        imagePath: photo.imagePath,
      );
    } catch (e) {
      if (!isClosed) {
        emit(PhotoError('Fotoğraf silinirken bir hata oluştu: $e'));
      }
    }
  }

  /// Cubit kapatılırken açık Stream subscription'ını da kapatıyoruz.
  ///
  /// Bu özellikle memory leak ve gereksiz database dinleyicilerini
  /// önlemek için önemlidir.
  @override
  Future<void> close() async {
    await _photosSubscription?.cancel();
    return super.close();
  }
}
