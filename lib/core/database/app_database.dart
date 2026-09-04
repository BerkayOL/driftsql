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

part 'app_database.g.dart';

@DriftDatabase(
  tables: [OfflinePhotosTable, BuildingsTable, FloorsTable, RoomsTable],
  daos: [PhotoDao, BuildingDao, FloorDao, RoomDao],
)
final class AppDatabase extends _$AppDatabase {
  AppDatabase.defaults() : super(driftDatabase(name: 'app_database'));

  AppDatabase(super.e);

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },

      onUpgrade: (Migrator m, int from, int to) async {
        /// Version 2:
        /// BuildingsTable eklendi.
        if (from < 2) {
          await m.createTable(buildingsTable);
        }

        /// Version 3:
        /// FloorsTable eklendi.
        if (from < 3) {
          await m.createTable(floorsTable);
        }

        /// Version 4:
        /// RoomsTable eklendi.
        ///
        /// RoomsTable, FloorsTable'a Foreign Key ile bağlıdır.
        if (from < 4) {
          await m.createTable(roomsTable);
        }

        /// Version 5: Mevcut fotoğrafları koruyan nullable Room foreign key'i.
        if (from < 5) {
          await m.addColumn(offlinePhotosTable, offlinePhotosTable.roomId);
        }
      },

      beforeOpen: (details) async {
        /// SQLite foreign key kontrollerini aktif eder.
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
