import '../models/building.dart';

abstract interface class BuildingRepository {
  Stream<List<Building>> watchAllBuildings();

  Stream<List<Building>> watchBuildingsByCountryAndYear({
    required String countryCode,
    required int builtBefore,
  });

  Future<Building?> getBuildingById(int id);

  Future<void> addBuilding({
    required String name,
    required String countryCode,
    required int constructionYear,
  });

  Future<void> deleteBuildingById(int id);
}
