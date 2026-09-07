import '../../data/dao/floor_dao.dart';

/// Kat ekranının alabileceği bütün durumların ortak üst tipidir.
/// `sealed` olduğu için bu dosyada tanımlanan durumlar dışında yeni bir alt
/// durum üretilemez; UI olası durumları güvenle ayırt edebilir.
sealed class FloorState {
  const FloorState();
}

/// FloorCubit henüz bir kat sorgusu başlatmadığında kullanılan ilk durum.
final class FloorInitial extends FloorState {
  const FloorInitial();
}

/// Kat sorgusu başlatıldıktan sonra ilk sonuç gelene kadar kullanılan durum.
final class FloorLoading extends FloorState {
  const FloorLoading();
}

/// Katlar, bağlı oldukları bina adıyla birlikte başarıyla geldiğinde yayınlanır.
final class FloorLoaded extends FloorState {
  /// Her eleman hem kat kaydını hem JOIN ile okunan bina adını taşır.
  final List<FloorWithBuilding> floors;

  const FloorLoaded(this.floors);
}

/// DAO sorgusu veya ekleme/silme işlemi başarısız olduğunda yayınlanır.
final class FloorError extends FloorState {
  /// Ekranın SnackBar içinde göstereceği kullanıcıya dönük hata açıklaması.
  final String message;

  const FloorError(this.message);
}
