import '../../../features/buildings/data/buildings_table.drift.dart';
import '../../../features/floors/data/floors_table.drift.dart';
import '../../../features/photos/data/offline_photos_table.drift.dart';
import '../../../features/rooms/data/rooms_table.drift.dart';

final class MigrationContext {
  const MigrationContext({
    required this.buildingsTable,
    required this.floorsTable,
    required this.roomsTable,
    required this.offlinePhotosTable,
  });

  final $BuildingsTableTable buildingsTable;
  final $FloorsTableTable floorsTable;
  final $RoomsTableTable roomsTable;
  final $OfflinePhotosTableTable offlinePhotosTable;
}
