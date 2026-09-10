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
  final List<PhotoWithLocation> photos;
  final bool hasMore;
  final bool isLoadingMore;
  final String? operationError;

  PhotoLoaded(
    this.photos, {
    required this.hasMore,
    this.isLoadingMore = false,
    this.operationError,
  });

  PhotoLoaded copyWith({
    List<PhotoWithLocation>? photos,
    bool? hasMore,
    bool? isLoadingMore,
    String? operationError,
    bool clearOperationError = false,
  }) {
    return PhotoLoaded(
      photos ?? this.photos,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      operationError: clearOperationError
          ? null
          : operationError ?? this.operationError,
    );
  }
}

/// Dosya sistemi, image picker veya database işlemi hata verdiğinde yayınlanır.
class PhotoError extends PhotoState {
  /// PhotoListPage'in SnackBar içinde göstereceği açıklama.
  final String message;

  PhotoError(this.message);
}
