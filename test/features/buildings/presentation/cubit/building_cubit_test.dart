import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:driftsql/core/database/app_database.dart';
import 'package:driftsql/features/buildings/data/buildings_table.drift.dart';
import 'package:driftsql/features/buildings/data/dao/building_dao.dart';
import 'package:driftsql/features/buildings/presentation/cubit/building_cubit.dart';
import 'package:driftsql/features/buildings/presentation/cubit/building_state.dart';

/// Gerçek BuildingDao'yu kullanır.
/// Sadece test etmek istediğimiz hata durumlarını kontrollü şekilde üretir.
final class TestBuildingDao extends BuildingDao {
  TestBuildingDao(super.database);

  bool failInsert = false;
  bool failWatch = false;

  @override
  Future<int> insertBuilding({
    required String name,
    required String countryCode,
    required int constructionYear,
  }) {
    if (failInsert) {
      return Future<int>.error(StateError('Test insert failure'));
    }

    return super.insertBuilding(
      name: name,
      countryCode: countryCode,
      constructionYear: constructionYear,
    );
  }

  @override
  Stream<List<BuildingsTableData>> watchAllBuildings() {
    if (failWatch) {
      return Stream<List<BuildingsTableData>>.error(
        StateError('Test watch failure'),
      );
    }

    return super.watchAllBuildings();
  }
}

void main() {
  late AppDatabase database;
  late TestBuildingDao buildingDao;
  late BuildingCubit cubit;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    buildingDao = TestBuildingDao(database);
    cubit = BuildingCubit(buildingDao);
  });

  tearDown(() async {
    await cubit.close();
    await database.close();
  });

  test('insert failure keeps existing loaded buildings', () async {
    // Önce database'e geçerli bir bina ekliyoruz.
    await database.buildingDao.insertBuilding(
      name: 'Existing Building',
      countryCode: 'TR',
      constructionYear: 2020,
    );

    // Cubit'in BuildingLoaded state'ine geçmesini bekliyoruz.
    final loadedFuture = cubit.stream.firstWhere(
      (state) => state is BuildingLoaded,
    );

    await cubit.watchAllBuildings();

    final initialLoaded = await loadedFuture as BuildingLoaded;

    expect(initialLoaded.buildings, hasLength(1));

    // Bundan sonraki INSERT'i bilinçli olarak bozuyoruz.
    buildingDao.failInsert = true;

    await cubit.addBuilding(
      name: 'Failed Building',
      countryCode: 'TR',
      constructionYear: 2025,
    );

    // Hata sonrası state hâlâ Loaded olmalı.
    expect(cubit.state, isA<BuildingLoaded>());

    final state = cubit.state as BuildingLoaded;

    // Mevcut data kaybolmamalı.
    expect(state.buildings, hasLength(1));
    expect(state.buildings.single.id, initialLoaded.buildings.single.id);

    // Hata ayrı olarak taşınmalı.
    expect(state.operationError, contains('Bina eklenirken hata oluştu'));
  });

  test('initial stream failure emits BuildingError', () async {
    buildingDao.failWatch = true;

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
      await database.buildingDao.insertBuilding(
        name: 'Existing Building',
        countryCode: 'TR',
        constructionYear: 2020,
      );

      final loadedFuture = cubit.stream.firstWhere(
        (state) => state is BuildingLoaded,
      );

      await cubit.watchAllBuildings();

      final initialLoaded = await loadedFuture as BuildingLoaded;

      expect(initialLoaded.buildings, hasLength(1));

      // Kontrollü şekilde INSERT hatası oluşturuyoruz.
      buildingDao.failInsert = true;

      await cubit.addBuilding(
        name: 'Failed Building',
        countryCode: 'TR',
        constructionYear: 2025,
      );

      final stateWithError = cubit.state as BuildingLoaded;

      expect(stateWithError.operationError, isNotNull);
      expect(stateWithError.buildings, hasLength(1));

      // UI SnackBar'ı gösterdikten sonra yaptığı işlemi simüle ediyoruz.
      cubit.clearOperationError();

      expect(cubit.state, isA<BuildingLoaded>());

      final clearedState = cubit.state as BuildingLoaded;

      // Hata temizlenmiş olmalı.
      expect(clearedState.operationError, isNull);

      // Ama mevcut veri kesinlikle kaybolmamalı.
      expect(clearedState.buildings, hasLength(1));
      expect(
        clearedState.buildings.single.id,
        initialLoaded.buildings.single.id,
      );
    },
  );
}
