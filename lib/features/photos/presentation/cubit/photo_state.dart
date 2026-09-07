// PhotoWithLocation sorgu sonuç tipini kullanacağımız için DAO'yu import ediyoruz.
import '../../data/dao/photo_dao.dart';

/// Fotoğraf ekranının gösterebileceği durumların ortak üst tipidir.
abstract class PhotoState {}

/// PhotoCubit oluşturuldu fakat fotoğraf sorgusu henüz başlatılmadı.
class PhotoInitial extends PhotoState {}

/// Fotoğraf seçme/kopyalama yapılırken veya ilk sorgu sonucu beklenirken kullanılır.
class PhotoLoading extends PhotoState {}

/// Fotoğraflar, varsa oda/kat/bina bilgileriyle birlikte başarıyla geldi.
class PhotoLoaded extends PhotoState {
  /// Bu liste yalnızca fotoğrafı değil, LEFT JOIN ile bulunan konumunu da taşır.
  final List<PhotoWithLocation> photos;

  PhotoLoaded(this.photos);
}

/// Dosya sistemi, image picker veya database işlemi hata verdiğinde yayınlanır.
class PhotoError extends PhotoState {
  /// PhotoListPage'in SnackBar içinde göstereceği açıklama.
  final String message;

  PhotoError(this.message);
}
