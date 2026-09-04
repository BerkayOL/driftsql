import '../../data/dao/floor_dao.dart';

sealed class FloorState {
  const FloorState();
}

final class FloorInitial extends FloorState {
  const FloorInitial();
}

final class FloorLoading extends FloorState {
  const FloorLoading();
}

final class FloorLoaded extends FloorState {
  final List<FloorWithBuilding> floors;

  const FloorLoaded(this.floors);
}

final class FloorError extends FloorState {
  final String message;

  const FloorError(this.message);
}
