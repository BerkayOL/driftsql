// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:driftsql/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'generated/schema.dart';

import 'generated/schema_v5.dart' as v5;
import 'generated/schema_v6.dart' as v6;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  // The following template shows how to write tests ensuring your migrations
  // preserve existing data.
  // Testing this can be useful for migrations that change existing columns
  // (e.g. by alterating their type or constraints). Migrations that only add
  // tables or columns typically don't need these advanced tests. For more
  // information, see https://drift.simonbinder.eu/migrations/tests/#verifying-data-integrity
  // TODO: This generated template shows how these tests could be written. Adopt
  // it to your own needs when testing migrations with data integrity.
  test('migration from v5 to v6 does not corrupt data', () async {
    // Add data to insert into the old database, and the expected rows after the
    // migration.
    // TODO: Fill these lists
    final oldBuildingsTableData = <v5.BuildingsTableData>[];
    final expectedNewBuildingsTableData = <v6.BuildingsTableData>[];

    final oldFloorsTableData = <v5.FloorsTableData>[];
    final expectedNewFloorsTableData = <v6.FloorsTableData>[];

    final oldRoomsTableData = <v5.RoomsTableData>[];
    final expectedNewRoomsTableData = <v6.RoomsTableData>[];

    final oldOfflinePhotosTableData = <v5.OfflinePhotosTableData>[];
    final expectedNewOfflinePhotosTableData = <v6.OfflinePhotosTableData>[];

    await verifier.testWithDataIntegrity(
      oldVersion: 5,
      newVersion: 6,
      createOld: v5.DatabaseAtV5.new,
      createNew: v6.DatabaseAtV6.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.buildingsTable, oldBuildingsTableData);
        batch.insertAll(oldDb.floorsTable, oldFloorsTableData);
        batch.insertAll(oldDb.roomsTable, oldRoomsTableData);
        batch.insertAll(oldDb.offlinePhotosTable, oldOfflinePhotosTableData);
      },
      validateItems: (newDb) async {
        expect(
          expectedNewBuildingsTableData,
          await newDb.select(newDb.buildingsTable).get(),
        );
        expect(
          expectedNewFloorsTableData,
          await newDb.select(newDb.floorsTable).get(),
        );
        expect(
          expectedNewRoomsTableData,
          await newDb.select(newDb.roomsTable).get(),
        );
        expect(
          expectedNewOfflinePhotosTableData,
          await newDb.select(newDb.offlinePhotosTable).get(),
        );
      },
    );
  });
}
