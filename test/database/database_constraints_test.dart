import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:driftsql/core/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('same building cannot contain duplicate floor numbers', () async {
    final buildingId = await database.customInsert('''
        INSERT INTO buildings_table (
          name,
          country_code,
          construction_year
        )
        VALUES ('Test Building', 'TR', 2020)
        ''');

    await database.customInsert('''
        INSERT INTO floors_table (
          building_id,
          name,
          floor_number
        )
        VALUES ($buildingId, 'First Floor', 1)
        ''');

    await expectLater(
      database.customInsert('''
          INSERT INTO floors_table (
            building_id,
            name,
            floor_number
          )
          VALUES ($buildingId, 'Another First Floor', 1)
          '''),
      throwsA(anything),
    );
  });

  test('room area must be greater than zero', () async {
    final buildingId = await database.customInsert('''
        INSERT INTO buildings_table (
          name,
          country_code,
          construction_year
        )
        VALUES ('Test Building', 'TR', 2020)
        ''');

    final floorId = await database.customInsert('''
        INSERT INTO floors_table (
          building_id,
          name,
          floor_number
        )
        VALUES ($buildingId, 'Ground Floor', 0)
        ''');

    await expectLater(
      database.customInsert('''
          INSERT INTO rooms_table (
            floor_id,
            name,
            area
          )
          VALUES ($floorId, 'Invalid Room', 0)
          '''),
      throwsA(anything),
    );

    await expectLater(
      database.customInsert('''
          INSERT INTO rooms_table (
            floor_id,
            name,
            area
          )
          VALUES ($floorId, 'Negative Room', -10)
          '''),
      throwsA(anything),
    );
  });
}
