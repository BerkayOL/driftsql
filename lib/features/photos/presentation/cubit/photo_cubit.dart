import 'dart:io';
import 'package:driftsql/features/photos/data/dao/photo_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../../../core/database/app_database.dart';
import 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  /// Cubit artık doğrudan AppDatabase ile çalışmıyor.
  ///
  /// Database sorgularını PhotoDao yönetiyor.
  final PhotoDao _photoDao;
  // Kamerayı veya galeriyi açmak için kullanacağımız paket.
  final ImagePicker _picker = ImagePicker();

  // Constructor: Cubit ilk oluştuğunda AppDatabase'i alır ve ekranı PhotoInitial(Başlangıç) durumuna çeker.
  PhotoCubit(this._photoDao) : super(PhotoInitial());

  // 1. FOTOĞRAFLARI VERİ TABANINDAN OKUMA FONKSİYONU
  Future<void> loadPhotos() async {
    // Arayüze "Ben veri tabanından okumaya başladım, sen ekranda dönen bir ikon göster" diyoruz.
    emit(PhotoLoading());
    try {
      // Drift ile tablodaki tüm verileri çekiyoruz (SELECT * FROM OfflinePhotosTable)
      final photos = await _photoDao.getAllPhotos();

      // Veriler başarıyla geldiyse, arayüze "Al bu fotoğrafları ekranda listele" diyoruz.
      emit(PhotoLoaded(photos));
    } catch (e) {
      // Hata oluşursa PhotoError durumuna geçiyoruz ve hata mesajını veriyoruz.
      emit(PhotoError('Fotoğraflar yüklenirken bir hata oluştu: $e'));
    }
  }

  // 2. FOTOĞRAF ÇEKME VE KALICI OLARAK KAYDETME FONKSİYONU
  Future<void> pickAndSavePhoto(ImageSource source) async {
    try {
      // Adım 1: Kullanıcının kamerayı/galeriyi açıp fotoğraf seçmesini bekle
      final XFile? pickedFile = await _picker.pickImage(source: source);

      // Eğer kullanıcı kamerayı açıp fotoğraf çekmeden geri tuşuna basarsa hiçbir şey yapma.
      if (pickedFile == null) return;

      // Kullanıcı fotoğrafı seçti. Kayıt işlemi süreceği için ekrana "Yükleniyor" durumunu fırlat.
      emit(PhotoLoading());

      // Adım 2: İşletim Sisteminden kalıcı klasörün adresini iste
      final directory = await getApplicationDocumentsDirectory();

      // Fotoğrafın adını al (örn: berkayislem1.jpg)
      final fileName = path.basename(pickedFile.path);

      // Fotoğrafın kopyalacağı YENİ ve KALICI adresini oluştur
      // Örn: /data/user/uygulama/berkayislem1.jpg
      final savedImage = File(path.join(directory.path, fileName));

      // Adım 3: Önbellekteki (Geçiçi) fotoğrafı, bu yeni kalıcı adrese kopyala
      await File(pickedFile.path).copy(savedImage.path);

      // Cubit artık INSERT sorgusu yazmıyor.
      //
      // Sadece DAO'ya kaydedilecek bilgiyi gönderiyor.
      await _photoDao.insertPhoto(imagePath: savedImage.path);

      await loadPhotos(); // Fotoğraf eklendikten sonra tekrar fotoğrafları yükle ve ekrana yansıt.
    } catch (e) {
      // Hata oluşursa PhotoError durumuna geçiyoruz ve hata mesajını veriyoruz.
      emit(PhotoError('Fotoğraf kaydedilirken bir hata oluştu: $e'));
    }
  }

  // 3. FOTOĞRAFI VERİ TABANINDAN SİLME FONKSİYONU
  Future<void> deletePhoto(OfflinePhotosTableData photo) async {
    try {
      // 1. Önce fiziksel dosyayı cihazın kalıcı hafızasından siliyoruz.
      final file = File(photo.imagePath);
      if (await file.exists()) {
        await file.delete();
      }
      // Database kaydını silme işlemi DAO'ya ait.
      await _photoDao.deletePhotoById(photo.id);
      // 3. İşlem bittikten sonra listeyi güncelle
      await loadPhotos();
    } catch (e) {
      // Hata oluşursa PhotoError durumuna geçiyoruz ve hata mesajını veriyoruz.
      emit(PhotoError('Fotoğraf silinirken bir hata oluştu: $e'));
    }
  }
}
