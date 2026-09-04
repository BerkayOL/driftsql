import '../../data/dao/room_dao.dart';

sealed class RoomState {
  const RoomState();
}

final class RoomInitial extends RoomState {
  const RoomInitial();
}

final class RoomLoading extends RoomState {
  const RoomLoading();
}

final class RoomLoaded extends RoomState {
  final List<RoomWithLocation> rooms;

  const RoomLoaded(this.rooms);
}

final class RoomError extends RoomState {
  final String message;

  const RoomError(this.message);
}
