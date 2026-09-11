// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:driftsql/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'generated/schema.dart';

import 'generated/schema_v6.dart' as v6;
import 'generated/schema_v7.dart' as v7;

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

  test('valid populated v6 data survives migration to v7', () async {
    const oldBuildings = [
      v6.BuildingsTableData(
        id: 1,
        name: 'Headquarters',
        countryCode: 'TR',
        constructionYear: 2018,
        createdAt: 1700000000,
      ),
    ];
    const oldFloors = [
      v6.FloorsTableData(
        id: 10,
        buildingId: 1,
        name: 'Ground Floor',
        floorNumber: 0,
        createdAt: 1700000010,
      ),
      v6.FloorsTableData(
        id: 11,
        buildingId: 1,
        name: 'First Floor',
        floorNumber: 1,
        createdAt: 1700000020,
      ),
    ];
    const oldRooms = [
      v6.RoomsTableData(
        id: 100,
        floorId: 10,
        name: 'Plant Room',
        isHeated: 0,
        area: 18.5,
        createdAt: 1700000030,
      ),
      v6.RoomsTableData(
        id: 101,
        floorId: 11,
        name: 'Office',
        isHeated: 1,
        targetTemperature: 21.5,
        area: 42,
        createdAt: 1700000040,
      ),
    ];
    const oldPhotos = [
      v6.OfflinePhotosTableData(
        id: 1000,
        imagePath: '/owned/photos/plant-room.jpg',
        roomId: 100,
        createdAt: 1700000050,
      ),
    ];

    await verifier.testWithDataIntegrity(
      oldVersion: 6,
      newVersion: 7,
      createOld: v6.DatabaseAtV6.new,
      createNew: v7.DatabaseAtV7.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.buildingsTable, oldBuildings);
        batch.insertAll(oldDb.floorsTable, oldFloors);
        batch.insertAll(oldDb.roomsTable, oldRooms);
        batch.insertAll(oldDb.offlinePhotosTable, oldPhotos);
      },
      validateItems: (newDb) async {
        expect(
          oldBuildings
              .map(
                (row) => v7.BuildingsTableData(
                  id: row.id,
                  name: row.name,
                  countryCode: row.countryCode,
                  constructionYear: row.constructionYear,
                  createdAt: row.createdAt,
                ),
              )
              .toList(),
          await newDb.select(newDb.buildingsTable).get(),
        );
        expect(
          oldFloors
              .map(
                (row) => v7.FloorsTableData(
                  id: row.id,
                  buildingId: row.buildingId,
                  name: row.name,
                  floorNumber: row.floorNumber,
                  createdAt: row.createdAt,
                ),
              )
              .toList(),
          await newDb.select(newDb.floorsTable).get(),
        );
        expect(
          oldRooms
              .map(
                (row) => v7.RoomsTableData(
                  id: row.id,
                  floorId: row.floorId,
                  name: row.name,
                  isHeated: row.isHeated,
                  targetTemperature: row.targetTemperature,
                  area: row.area,
                  createdAt: row.createdAt,
                ),
              )
              .toList(),
          await newDb.select(newDb.roomsTable).get(),
        );
        expect(
          oldPhotos
              .map(
                (row) => v7.OfflinePhotosTableData(
                  id: row.id,
                  imagePath: row.imagePath,
                  roomId: row.roomId,
                  createdAt: row.createdAt,
                ),
              )
              .toList(),
          await newDb.select(newDb.offlinePhotosTable).get(),
        );

        final foreignKeyViolations = await newDb
            .customSelect('PRAGMA foreign_key_check')
            .get();
        expect(foreignKeyViolations, isEmpty);

        await expectLater(
          newDb.customInsert('''
            INSERT INTO floors_table (
              building_id,
              name,
              floor_number,
              created_at
            ) VALUES (1, 'Duplicate Ground Floor', 0, 1700000060)
          '''),
          throwsA(anything),
        );
        await expectLater(
          newDb.customInsert('''
            INSERT INTO rooms_table (
              floor_id,
              name,
              area,
              created_at
            ) VALUES (10, 'Invalid Room', 0, 1700000070)
          '''),
          throwsA(anything),
        );
      },
    );
  });

  test('v6 duplicate floor numbers make v6 to v7 migration fail', () async {
    await expectLater(
      verifier.testWithDataIntegrity(
        oldVersion: 6,
        newVersion: 7,
        createOld: v6.DatabaseAtV6.new,
        createNew: v7.DatabaseAtV7.new,
        openTestedDatabase: AppDatabase.new,
        createItems: (batch, oldDb) {
          batch.insert(
            oldDb.buildingsTable,
            const v6.BuildingsTableData(
              id: 1,
              name: 'Legacy Building',
              countryCode: 'TR',
              constructionYear: 2000,
              createdAt: 1700000000,
            ),
          );
          batch.insertAll(oldDb.floorsTable, const [
            v6.FloorsTableData(
              id: 10,
              buildingId: 1,
              name: 'First Floor A',
              floorNumber: 1,
              createdAt: 1700000010,
            ),
            v6.FloorsTableData(
              id: 11,
              buildingId: 1,
              name: 'First Floor B',
              floorNumber: 1,
              createdAt: 1700000020,
            ),
          ]);
        },
        validateItems: (_) async {},
      ),
      throwsA(
        predicate<Object>(
          (error) => error.toString().contains('UNIQUE constraint failed'),
          'a UNIQUE constraint migration failure',
        ),
      ),
    );
  });

  for (final invalidArea in [0.0, -12.5]) {
    test('v6 room area $invalidArea makes v6 to v7 migration fail', () async {
      await expectLater(
        verifier.testWithDataIntegrity(
          oldVersion: 6,
          newVersion: 7,
          createOld: v6.DatabaseAtV6.new,
          createNew: v7.DatabaseAtV7.new,
          openTestedDatabase: AppDatabase.new,
          createItems: (batch, oldDb) {
            batch.insert(
              oldDb.buildingsTable,
              const v6.BuildingsTableData(
                id: 1,
                name: 'Legacy Building',
                countryCode: 'TR',
                constructionYear: 2000,
                createdAt: 1700000000,
              ),
            );
            batch.insert(
              oldDb.floorsTable,
              const v6.FloorsTableData(
                id: 10,
                buildingId: 1,
                name: 'Ground Floor',
                floorNumber: 0,
                createdAt: 1700000010,
              ),
            );
            batch.insert(
              oldDb.roomsTable,
              v6.RoomsTableData(
                id: 100,
                floorId: 10,
                name: 'Invalid Legacy Room',
                isHeated: 1,
                targetTemperature: 20,
                area: invalidArea,
                createdAt: 1700000020,
              ),
            );
          },
          validateItems: (_) async {},
        ),
        throwsA(
          predicate<Object>(
            (error) => error.toString().contains('CHECK constraint failed'),
            'a CHECK constraint migration failure',
          ),
        ),
      );
    });
  }
}
