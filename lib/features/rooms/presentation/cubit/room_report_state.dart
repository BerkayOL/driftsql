import '../../data/dao/room_dao.dart';

sealed class RoomReportState {
  const RoomReportState();
}

final class RoomReportLoading extends RoomReportState {
  const RoomReportLoading();
}

final class RoomReportLoaded extends RoomReportState {
  final RoomReport report;
  final List<RoomWithLocation> filteredRooms;
  final String countryCode;
  final int builtBefore;

  const RoomReportLoaded({
    required this.report,
    required this.filteredRooms,
    required this.countryCode,
    required this.builtBefore,
  });
}

final class RoomReportError extends RoomReportState {
  final String message;

  const RoomReportError(this.message);
}
