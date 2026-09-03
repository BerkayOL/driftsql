import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../features/buildings/data/buildings_table.dart';
import '../../features/buildings/data/dao/building_dao.dart';
import '../../features/floors/data/floors_table.dart';
import '../../features/photos/data/dao/photo_dao.dart';
import '../../features/photos/data/offline_photos_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [OfflinePhotosTable, BuildingsTable, FloorsTable],
  daos: [PhotoDao, BuildingDao],
)
final class AppDatabase extends _$AppDatabase {
  AppDatabase.defaults() : super(driftDatabase(name: 'app_database'));

  AppDatabase(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },

      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(buildingsTable);
        }

        if (from < 3) {
          await m.createTable(floorsTable);
        }
      },

      beforeOpen: (details) async {
        /// SQLite foreign key kontrollerini aktif eder.
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
