// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_dao.dart';

// ignore_for_file: type=lint
mixin _$BuildingDaoMixin on DatabaseAccessor<AppDatabase> {
  $BuildingsTableTable get buildingsTable => attachedDatabase.buildingsTable;
  BuildingDaoManager get managers => BuildingDaoManager(this);
}

class BuildingDaoManager {
  final _$BuildingDaoMixin _db;
  BuildingDaoManager(this._db);
  $$BuildingsTableTableTableManager get buildingsTable =>
      $$BuildingsTableTableTableManager(
        _db.attachedDatabase,
        _db.buildingsTable,
      );
}
