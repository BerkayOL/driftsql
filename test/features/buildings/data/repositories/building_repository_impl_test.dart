import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:driftsql/core/database/app_database.dart';
import 'package:driftsql/features/buildings/data/repositories/building_repository_impl.dart';
import 'package:driftsql/features/buildings/domain/models/building.dart';

void main() {
  late AppDatabase database;
  late BuildingRepositoryImpl repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = BuildingRepositoryImpl(database.buildingDao);
  });

  tearDown(() async {
    await database.close();
  });

  test('watchAllBuildings maps Drift rows to domain Building models', () async {
    await database.buildingDao.insertBuilding(
      name: 'Test Building',
      countryCode: 'TR',
      constructionYear: 2020,
    );

    final buildings = await repository.watchAllBuildings().first;

    expect(buildings, hasLength(1));
    expect(buildings.single, isA<Building>());

    final building = buildings.single;

    expect(building.name, 'Test Building');
    expect(building.countryCode, 'TR');
    expect(building.constructionYear, 2020);
  });

  test('addBuilding stores data through repository', () async {
    await repository.addBuilding(
      name: 'Repository Building',
      countryCode: 'DE',
      constructionYear: 1995,
    );

    final buildings = await repository.watchAllBuildings().first;

    expect(buildings, hasLength(1));
    expect(buildings.single.name, 'Repository Building');
    expect(buildings.single.countryCode, 'DE');
    expect(buildings.single.constructionYear, 1995);
  });

  test('deleteBuildingById removes building through repository', () async {
    final id = await database.buildingDao.insertBuilding(
      name: 'Delete Me',
      countryCode: 'TR',
      constructionYear: 2010,
    );

    await repository.deleteBuildingById(id);

    final buildings = await repository.watchAllBuildings().first;

    expect(buildings, isEmpty);
  });
}
