import 'package:drift/drift.dart';
import 'package:driftsql/core/database/app_database.steps.dart';

import 'migration_context.dart';

Future<void> runMigrationsV001V010({
  required Migrator migrator,
  required int from,
  required int to,
  required MigrationContext context,
}) async {
  // Version 2: BuildingsTable eklendi.
  if (from < 2 && to >= 2) {
    await migrator.createTable(context.buildingsTable);
  }

  // Version 3: FloorsTable eklendi.
  if (from < 3 && to >= 3) {
    await migrator.createTable(context.floorsTable);
  }

  // Version 4: RoomsTable eklendi.
  if (from < 4 && to >= 4) {
    await migrator.createTable(context.roomsTable);
  }

  // Version 5:
  // Mevcut fotoğrafları koruyan nullable Room foreign key'i eklendi.
  if (from < 5 && to >= 5) {
    await migrator.addColumn(
      context.offlinePhotosTable,
      context.offlinePhotosTable.roomId,
    );
  }
}

/// v5 -> v6
/// Sık kullanılan sorgular için composite index'ler eklendi.
Future<void> migrateFrom5To6(Migrator migrator, Schema6 schema) async {
  await migrator.createIndex(schema.idxFloorsBuildingFloorNumber);

  await migrator.createIndex(schema.idxRoomFloorName);

  await migrator.createIndex(schema.idxOfflinePhotosRoomCreatedAt);
}

/// v6 -> v7
/// - floors(building_id, floor_number) index'i UNIQUE hale getirildi.
/// - rooms.area için CHECK (area > 0) eklendi.
Future<void> migrateFrom6To7(Migrator migrator, Schema7 schema) async {
  // Rooms tablosu yeniden oluşturulur ve yeni CHECK constraint uygulanır.
  await migrator.alterTable(TableMigration(schema.roomsTable));

  // Aynı isimdeki normal index kaldırılır.
  await migrator.drop(schema.idxFloorsBuildingFloorNumber);

  // Aynı index UNIQUE olarak yeniden oluşturulur.
  await migrator.createIndex(schema.idxFloorsBuildingFloorNumber);
}

Future<void> migrateFrom7To8(Migrator migrator, Schema8 schema) async {
  await migrator.createTable(schema.pendingFileCleanupTable);
}
