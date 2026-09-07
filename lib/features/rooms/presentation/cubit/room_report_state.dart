import '../../data/dao/room_dao.dart';

/// İlişkisel rapor ekranının gösterebileceği durumların ortak üst tipidir.
sealed class RoomReportState {
  const RoomReportState();
}

/// Genel rapor ve filtrelenmiş oda sorgularından en az biri henüz hazır değil.
final class RoomReportLoading extends RoomReportState {
  const RoomReportLoading();
}

/// Cubit'in dinlediği iki sorgunun da sonucu hazır olduğunda yayınlanır.
final class RoomReportLoaded extends RoomReportState {
  /// Bütün odalar üzerinden SQL COUNT, SUM ve AVG ile hesaplanan özet.
  final RoomReport report;

  /// Ülke, yapım yılı ve ısıtma koşuluna uyan JOIN sonuçları.
  final List<RoomWithLocation> filteredRooms;

  /// UI'ın hangi filtrenin uygulandığını yazabilmesi için state'te tutulur.
  final String countryCode;
  final int builtBefore;

  const RoomReportLoaded({
    required this.report,
    required this.filteredRooms,
    required this.countryCode,
    required this.builtBefore,
  });
}

/// İki rapor stream'inden biri hata verdiğinde yayınlanır.
final class RoomReportError extends RoomReportState {
  final String message;

  const RoomReportError(this.message);
}
