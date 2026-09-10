import 'package:driftsql/features/photos/data/dao/photo_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/services/photo_persistence_service.dart';
import '../../data/services/photo_storage_service.dart';

import '../../data/models/photo_page.dart';

import 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  /// Fotoğraf database işlemleri DAO tarafından yönetilir.
  final PhotoDao _photoDao;

  /// Kamera veya galeriyi açmak için kullanılır.
  final ImagePicker _picker = ImagePicker();

  /// File System + SQLite arasında yapılan write işlemlerini koordine eder.
  final PhotoPersistenceService _photoPersistenceService;

  static const int _pageSize = 30;

  PhotoCursor? _nextCursor;
  int? _currentRoomId;
  bool _isLoadingMore = false;

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

  Future<void> loadInitialPage({int? roomId}) async {
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

      _nextCursor = page.nextCursor;

      if (!isClosed) {
        emit(PhotoLoaded(page.items, hasMore: page.hasMore));
      }
    } catch (e) {
      if (!isClosed) {
        emit(PhotoError('Fotoğraflar yüklenirken bir hata oluştu: $e'));
      }
    }
  }

  Future<void> loadMore() async {
    final currentState = state;

    if (currentState is! PhotoLoaded ||
        !currentState.hasMore ||
        currentState.isLoadingMore ||
        _isLoadingMore ||
        _nextCursor == null) {
      return;
    }

    _isLoadingMore = true;

    emit(currentState.copyWith(isLoadingMore: true, clearOperationError: true));

    try {
      final page = await _photoDao.getPhotosPage(
        roomId: _currentRoomId,
        cursor: _nextCursor,
        pageSize: _pageSize,
      );

      _nextCursor = page.nextCursor;

      if (!isClosed) {
        emit(
          currentState.copyWith(
            photos: [...currentState.photos, ...page.items],
            hasMore: page.hasMore,
            isLoadingMore: false,
            clearOperationError: true,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          currentState.copyWith(
            isLoadingMore: false,
            operationError: 'Daha fazla fotoğraf yüklenirken hata oluştu: $e',
          ),
        );
      }
    } finally {
      _isLoadingMore = false;
    }
  }

  /// Kamera veya galeriden fotoğraf alır,
  /// kalıcı dosya alanına kaydeder
  /// ve database'e local path bilgisini ekler.
  Future<void> pickAndSavePhoto(ImageSource source, {int? roomId}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile == null) return;

      emit(PhotoLoading());
      await loadInitialPage(roomId: _currentRoomId ?? roomId);
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
      await loadInitialPage(roomId: _currentRoomId);
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
}
