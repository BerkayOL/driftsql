import 'dart:async';
import 'dart:io';

import 'package:driftsql/features/photos/data/dao/photo_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../core/database/app_database.dart';
import 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  /// Fotoğraf database işlemleri DAO tarafından yönetilir.
  final PhotoDao _photoDao;

  /// Kamera veya galeriyi açmak için kullanılır.
  final ImagePicker _picker = ImagePicker();

  /// Drift'in gönderdiği fotoğraf listesini dinlemek için kullanılır.
  ///
  /// Bu subscription sayesinde Cubit,
  /// database değişikliklerini sürekli takip edebilir.
  StreamSubscription<List<OfflinePhotosTableData>>?
      _photosSubscription;

  PhotoCubit(this._photoDao) : super(PhotoInitial());

  /// Fotoğraf tablosunu reactive olarak izlemeye başlar.
  ///
  /// Eskiden:
  /// getAllPhotos() ile veriyi bir kere çekiyorduk.
  ///
  /// Şimdi:
  /// watchAllPhotos() ile tabloyu sürekli izliyoruz.
  Future<void> watchPhotos() async {
    emit(PhotoLoading());

    // Bu metod birden fazla kez çağrılırsa
    // eski dinleyiciyi kapatıp yenisini oluşturuyoruz.
    await _photosSubscription?.cancel();

    _photosSubscription = _photoDao.watchAllPhotos().listen(
      (photos) {
        // Database değiştiğinde Drift bize yeni listeyi gönderir.
        if (!isClosed) {
          emit(PhotoLoaded(photos));
        }
      },
      onError: (Object error, StackTrace stackTrace) {
        if (!isClosed) {
          emit(
            PhotoError(
              'Fotoğraflar izlenirken bir hata oluştu: $error',
            ),
          );
        }
      },
    );
  }

  /// Kamera veya galeriden fotoğraf alır,
  /// kalıcı dosya alanına kaydeder
  /// ve database'e local path bilgisini ekler.
  Future<void> pickAndSavePhoto(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );

      if (pickedFile == null) return;

      emit(PhotoLoading());

      final directory =
          await getApplicationDocumentsDirectory();

      final fileName = path.basename(
        pickedFile.path,
      );

      final savedImage = File(
        path.join(
          directory.path,
          fileName,
        ),
      );

      // ImagePicker'ın geçici dosyasını
      // uygulamanın kalıcı klasörüne kopyalıyoruz.
      await File(
        pickedFile.path,
      ).copy(savedImage.path);

      // Database kaydını DAO oluşturuyor.
      await _photoDao.insertPhoto(
        imagePath: savedImage.path,
      );

      // DİKKAT:
      // Artık loadPhotos() çağırmıyoruz.
      //
      // INSERT gerçekleşince Drift'in .watch() sorgusu
      // değişikliği otomatik algılayacak ve yeni listeyi yayınlayacak.
    } catch (e) {
      emit(
        PhotoError(
          'Fotoğraf kaydedilirken bir hata oluştu: $e',
        ),
      );
    }
  }

  /// Fotoğrafın fiziksel dosyasını
  /// ve database kaydını siler.
  Future<void> deletePhoto(
    OfflinePhotosTableData photo,
  ) async {
    try {
      final file = File(photo.imagePath);

      if (await file.exists()) {
        await file.delete();
      }

      await _photoDao.deletePhotoById(
        photo.id,
      );

      // Artık burada da loadPhotos() yok.
      //
      // DELETE işlemi database'i değiştirdiği için
      // .watch() otomatik olarak yeni liste yayınlayacak.
    } catch (e) {
      emit(
        PhotoError(
          'Fotoğraf silinirken bir hata oluştu: $e',
        ),
      );
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