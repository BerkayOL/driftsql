import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:driftsql/features/rooms/data/dao/room_dao.dart';

import '../../features/buildings/data/buildings_table.dart';
import '../../features/buildings/data/dao/building_dao.dart';
import '../../features/floors/data/dao/floor_dao.dart';
import '../../features/floors/data/floors_table.dart';
import '../../features/photos/data/dao/photo_dao.dart';
import '../../features/photos/data/offline_photos_table.dart';
import '../../features/rooms/data/rooms_table.dart';
import 'migrations/migration_context.dart';
import 'migrations/migration_runner.dart';
import '../../features/photos/data/pending_file_cleanup_table.dart';
import 'app_database.drift.dart';

@DriftDatabase(
  tables: [
    OfflinePhotosTable,
    BuildingsTable,
    FloorsTable,
    RoomsTable,
    PendingFileCleanupTable,
  ],
  daos: [PhotoDao, BuildingDao, FloorDao, RoomDao],
)
final class AppDatabase extends $AppDatabase {
  AppDatabase.defaults() : super(driftDatabase(name: 'app_database'));

  AppDatabase(super.e);

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },

      onUpgrade: (Migrator m, int from, int to) async {
        await runMigrations(
          migrator: m,
          from: from,
          to: to,
          context: MigrationContext(
            buildingsTable: buildingsTable,
            floorsTable: floorsTable,
            roomsTable: roomsTable,
            offlinePhotosTable: offlinePhotosTable,
          ),
        );
      },

      beforeOpen: (details) async {
        /// SQLite foreign key kontrollerini aktif eder.
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
