import '../../domain/models/building.dart';
import '../../domain/repositories/building_repository.dart';
import '../dao/building_dao.dart';
import '../mappers/building_mapper.dart';

final class BuildingRepositoryImpl implements BuildingRepository {
  final BuildingDao _buildingDao;

  const BuildingRepositoryImpl(this._buildingDao);

  @override
  Stream<List<Building>> watchAllBuildings() {
    return _buildingDao.watchAllBuildings().map(
      (rows) => rows.map((row) => row.toDomain()).toList(),
    );
  }

  @override
  Stream<List<Building>> watchBuildingsByCountryAndYear({
    required String countryCode,
    required int builtBefore,
  }) {
    return _buildingDao
        .watchBuildingsByCountryAndYear(
          countryCode: countryCode,
          builtBefore: builtBefore,
        )
        .map((rows) => rows.map((row) => row.toDomain()).toList());
  }

  @override
  Future<Building?> getBuildingById(int id) async {
    final row = await _buildingDao.getBuildingById(id);

    return row?.toDomain();
  }

  @override
  Future<void> addBuilding({
    required String name,
    required String countryCode,
    required int constructionYear,
  }) async {
    await _buildingDao.insertBuilding(
      name: name,
      countryCode: countryCode,
      constructionYear: constructionYear,
    );
  }

  @override
  Future<void> deleteBuildingById(int id) async {
    await _buildingDao.deleteBuildingById(id);
  }
}
