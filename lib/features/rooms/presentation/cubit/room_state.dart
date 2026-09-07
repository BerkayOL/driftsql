import '../../data/dao/room_dao.dart';

/// Belirli bir kata ait oda listesinin UI durumlarını tanımlar.
sealed class RoomState {
  const RoomState();
}

/// RoomCubit oluşturuldu fakat henüz `watchRooms` çağrılmadı.
final class RoomInitial extends RoomState {
  const RoomInitial();
}

/// Oda listesinin ilk database sonucu bekleniyor.
final class RoomLoading extends RoomState {
  const RoomLoading();
}

/// JOIN sonucundaki odalar, katları ve binalarıyla beraber hazırdır.
final class RoomLoaded extends RoomState {
  /// `RoomWithLocation`, Room tablosuna ek olarak Floor ve Building verisini
  /// taşıyan bir sorgu sonuç modelidir; ayrı bir database tablosu değildir.
  final List<RoomWithLocation> rooms;

  const RoomLoaded(this.rooms);
}

/// Oda sorgusunda veya CRUD işleminde hata oluştuğunu UI'a bildirir.
final class RoomError extends RoomState {
  final String message;

  const RoomError(this.message);
}
