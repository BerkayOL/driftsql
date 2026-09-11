import 'package:flutter_test/flutter_test.dart';

import 'package:driftsql/features/buildings/domain/models/building.dart';
import 'package:driftsql/features/buildings/domain/repositories/building_repository.dart';
import 'package:driftsql/features/buildings/presentation/cubit/building_cubit.dart';
import 'package:driftsql/features/buildings/presentation/cubit/building_state.dart';

final class TestBuildingRepository implements BuildingRepository {
  bool failAdd = false;
  bool failWatch = false;

  final List<Building> _buildings = [
    Building(
      id: 1,
      name: 'Existing Building',
      countryCode: 'TR',
      constructionYear: 2020,
      createdAt: DateTime(2020),
    ),
  ];

  @override
  Stream<List<Building>> watchAllBuildings() {
    if (failWatch) {
      return Stream<List<Building>>.error(StateError('Test watch failure'));
    }

    return Stream.value(List<Building>.unmodifiable(_buildings));
  }

  @override
  Stream<List<Building>> watchBuildingsByCountryAndYear({
    required String countryCode,
    required int builtBefore,
  }) {
    final filtered = _buildings
        .where(
          (building) =>
              building.countryCode == countryCode &&
              building.constructionYear < builtBefore,
        )
        .toList();

    return Stream.value(filtered);
  }

  @override
  Future<Building?> getBuildingById(int id) async {
    for (final building in _buildings) {
      if (building.id == id) {
        return building;
      }
    }

    return null;
  }

  @override
  Future<void> addBuilding({
    required String name,
    required String countryCode,
    required int constructionYear,
  }) async {
    if (failAdd) {
      throw StateError('Test insert failure');
    }

    _buildings.add(
      Building(
        id: _buildings.length + 1,
        name: name,
        countryCode: countryCode,
        constructionYear: constructionYear,
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> deleteBuildingById(int id) async {
    _buildings.removeWhere((building) => building.id == id);
  }
}

void main() {
  late TestBuildingRepository repository;
  late BuildingCubit cubit;

  setUp(() {
    repository = TestBuildingRepository();
    cubit = BuildingCubit(repository);
  });

  tearDown(() async {
    await cubit.close();
  });

  test('insert failure keeps existing loaded buildings', () async {
    final loadedFuture = cubit.stream.firstWhere(
      (state) => state is BuildingLoaded,
    );

    await cubit.watchAllBuildings();

    final initialLoaded = await loadedFuture as BuildingLoaded;

    expect(initialLoaded.buildings, hasLength(1));

    repository.failAdd = true;

    await cubit.addBuilding(
      name: 'Failed Building',
      countryCode: 'TR',
      constructionYear: 2025,
    );

    expect(cubit.state, isA<BuildingLoaded>());

    final state = cubit.state as BuildingLoaded;

    expect(state.buildings, hasLength(1));

    expect(state.buildings.single.id, initialLoaded.buildings.single.id);

    expect(state.operationError, contains('Bina eklenirken hata oluştu'));
  });

  test('initial stream failure emits BuildingError', () async {
    repository.failWatch = true;

    final errorFuture = cubit.stream.firstWhere(
      (state) => state is BuildingError,
    );

    await cubit.watchAllBuildings();

    final state = await errorFuture as BuildingError;

    expect(state.message, contains('Binalar yüklenirken hata oluştu'));
  });

  test(
    'clearOperationError removes error without losing loaded buildings',
    () async {
      final loadedFuture = cubit.stream.firstWhere(
        (state) => state is BuildingLoaded,
      );

      await cubit.watchAllBuildings();

      final initialLoaded = await loadedFuture as BuildingLoaded;

      expect(initialLoaded.buildings, hasLength(1));

      repository.failAdd = true;

      await cubit.addBuilding(
        name: 'Failed Building',
        countryCode: 'TR',
        constructionYear: 2025,
      );

      final stateWithError = cubit.state as BuildingLoaded;

      expect(stateWithError.operationError, isNotNull);
      expect(stateWithError.buildings, hasLength(1));

      cubit.clearOperationError();

      expect(cubit.state, isA<BuildingLoaded>());

      final clearedState = cubit.state as BuildingLoaded;

      expect(clearedState.operationError, isNull);
      expect(clearedState.buildings, hasLength(1));

      expect(
        clearedState.buildings.single.id,
        initialLoaded.buildings.single.id,
      );
    },
  );
}
