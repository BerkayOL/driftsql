// app_database.dart dosyamızı import ediyoruz çünkü Drift'in bizim için ürettiği
// "OfflinePhotosTableData" (fotoğraf nesnesi) sınıfını kullanacağız.
import '../../../../core/database/app_database.dart';

// Tüm durumların atası olan temel sınıf.
// UI tarafında 'Eğer gelen durum PhotoState ise...' diyebilmek için bir çatı oluşturuyoruz.
abstract class PhotoState {}

// 1. Başlangıç Durumu
class PhotoInitial extends PhotoState {}

// 2. Yükleniyor Durumu (Ekranda CircularProgressIndicator göstermek için kullanacağız)
class PhotoLoading extends PhotoState {}

// 3. Başarılı Durumu
class PhotoLoaded extends PhotoState {
  // Drift'in ürettiği "OfflinePhotosTableData" sınıfından bir liste alıyoruz.
  final List<OfflinePhotosTableData> photos;

  // Constructor
  PhotoLoaded(this.photos);
}

// 4. Hata Durumu (Ekranda SnackBar ile hata mesajı göstereceğiz)
class PhotoError extends PhotoState {
  // Hata mesajını tutacak bir değişken
  final String message;

  // Constructor
  PhotoError(this.message);
}
