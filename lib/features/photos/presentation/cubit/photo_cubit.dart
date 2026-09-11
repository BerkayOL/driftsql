import 'package:driftsql/features/photos/data/dao/photo_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/photo_page.dart';
import '../../data/services/photo_persistence_service.dart';
import '../../data/services/photo_storage_service.dart';
import 'photo_state.dart';

typedef PhotoPicker = Future<XFile?> Function(ImageSource source);

class PhotoCubit extends Cubit<PhotoState> {
  /// Fotoğraf okuma ve pagination sorgularını yönetir.
  final PhotoDao _photoDao;

  /// Kamera / galeri seçimini test edilebilir hale getiren abstraction.
  final PhotoPicker _pickPhoto;

  /// File System + SQLite write işlemlerinin consistency katmanı.
  final PhotoPersistenceService _photoPersistenceService;

  static const int _pageSize = 30;

  PhotoCursor? _nextCursor;
  int? _currentRoomId;

  bool _isLoadingMore = false;

  /// Eski async isteklerin daha yeni ekran sonucunu ezmesini engeller.
  int _requestVersion = 0;

  PhotoCubit(
    PhotoDao photoDao, {
    PhotoPersistenceService? persistenceService,
    PhotoPicker? picker,
  }) : _photoDao = photoDao,
       _photoPersistenceService =
           persistenceService ??
           PhotoPersistenceService(
             photoDao: photoDao,
             storageService: PhotoStorageService(),
           ),
       _pickPhoto =
           picker ??
           ((source) {
             return ImagePicker().pickImage(source: source);
           }),
       super(PhotoInitial());

  /// İlk fotoğraf sayfasını yükler.
  ///
  /// Yeni bir initial request başladığında önceki pagination request'leri
  /// artık geçersiz kabul edilir.
  Future<void> loadInitialPage({int? roomId}) async {
    final requestVersion = ++_requestVersion;

    _currentRoomId = roomId;
    _nextCursor = null;
    _isLoadingMore = false;

    if (!isClosed) {
      emit(PhotoLoading());
    }

    try {
      await _photoPersistenceService.retryPendingCleanups();

      final page = await _photoDao.getPhotosPage(
        roomId: roomId,
        pageSize: _pageSize,
      );

      if (isClosed || requestVersion != _requestVersion) {
        return;
      }

      _nextCursor = page.nextCursor;

      emit(PhotoLoaded(page.items, hasMore: page.hasMore));
    } catch (e) {
      if (isClosed || requestVersion != _requestVersion) {
        return;
      }

      emit(PhotoError('Fotoğraflar yüklenirken bir hata oluştu: $e'));
    }
  }

  /// Cursor üzerinden sonraki sayfayı yükler.
  Future<void> loadMore() async {
    final currentState = state;

    if (currentState is! PhotoLoaded ||
        !currentState.hasMore ||
        currentState.isLoadingMore ||
        _isLoadingMore ||
        _nextCursor == null) {
      return;
    }

    final requestVersion = _requestVersion;

    _isLoadingMore = true;

    emit(currentState.copyWith(isLoadingMore: true, clearOperationError: true));

    try {
      final page = await _photoDao.getPhotosPage(
        roomId: _currentRoomId,
        cursor: _nextCursor,
        pageSize: _pageSize,
      );

      if (isClosed || requestVersion != _requestVersion) {
        return;
      }

      _nextCursor = page.nextCursor;

      emit(
        currentState.copyWith(
          photos: [...currentState.photos, ...page.items],
          hasMore: page.hasMore,
          isLoadingMore: false,
          clearOperationError: true,
        ),
      );
    } catch (e) {
      if (isClosed || requestVersion != _requestVersion) {
        return;
      }

      emit(
        currentState.copyWith(
          isLoadingMore: false,
          operationError: 'Daha fazla fotoğraf yüklenirken hata oluştu: $e',
        ),
      );
    } finally {
      if (requestVersion == _requestVersion) {
        _isLoadingMore = false;
      }
    }
  }

  /// Fotoğrafı önce persistence katmanına kaydeder.
  ///
  /// İşlem başarılı olduktan sonra ilk sayfa yenilenir.
  /// Böylece pagination artık reactive `.watch()` kullanmadığı için
  /// UI'ın eski listeyi göstermesi engellenir.
  Future<void> pickAndSavePhoto(ImageSource source, {int? roomId}) async {
    try {
      final pickedFile = await _pickPhoto(source);

      if (pickedFile == null) {
        return;
      }

      final targetRoomId = roomId ?? _currentRoomId;

      // ÖNEMLİ:
      // Önce mutation yapılır.
      await _photoPersistenceService.savePhoto(
        sourcePath: pickedFile.path,
        roomId: targetRoomId,
      );

      // Mutation başarılı olduktan sonra liste yenilenir.
      try {
        await _refreshCurrentPage();
      } catch (e) {
        _emitOperationError('Fotoğraf kaydedildi ancak liste yenilenemedi: $e');
      }
    } catch (e) {
      _emitOperationError('Fotoğraf kaydedilirken bir hata oluştu: $e');
    }
  }

  /// Database kaydını ve fiziksel dosya lifecycle'ını
  /// persistence service üzerinden yönetir.
  Future<void> deletePhoto(PhotoWithLocation result) async {
    try {
      final photo = result.photo;

      // ÖNEMLİ:
      // Önce gerçek silme işlemi yapılır.
      await _photoPersistenceService.deletePhoto(
        photoId: photo.id,
        imagePath: photo.imagePath,
      );

      // Silme tamamlandıktan sonra pagination başlangıcı yenilenir.
      try {
        await _refreshCurrentPage();
      } catch (e) {
        _emitOperationError('Fotoğraf silindi ancak liste yenilenemedi: $e');
      }
    } catch (e) {
      _emitOperationError('Fotoğraf silinirken bir hata oluştu: $e');
    }
  }

  /// CRUD sonrası tam ekran loading state'ine dönmeden
  /// güncel ilk sayfayı getirir.
  Future<void> _refreshCurrentPage() async {
    final requestVersion = ++_requestVersion;

    _nextCursor = null;
    _isLoadingMore = false;

    final page = await _photoDao.getPhotosPage(
      roomId: _currentRoomId,
      pageSize: _pageSize,
    );

    if (isClosed || requestVersion != _requestVersion) {
      return;
    }

    _nextCursor = page.nextCursor;

    emit(PhotoLoaded(page.items, hasMore: page.hasMore));
  }

  /// Operation error oluştuğunda kullanılabilir mevcut listeyi korur.
  void _emitOperationError(String message) {
    if (isClosed) {
      return;
    }

    final currentState = state;

    if (currentState is PhotoLoaded) {
      emit(currentState.copyWith(operationError: message));
    } else {
      emit(PhotoError(message));
    }
  }

  /// Snackbar tarafından tüketilen geçici operation error'u temizler.
  void clearOperationError() {
    final currentState = state;

    if (currentState is PhotoLoaded &&
        currentState.operationError != null &&
        !isClosed) {
      emit(currentState.copyWith(clearOperationError: true));
    }
  }
}
