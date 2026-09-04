// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_dao.dart';

// ignore_for_file: type=lint
mixin _$FloorDaoMixin on DatabaseAccessor<AppDatabase> {
  $BuildingsTableTable get buildingsTable => attachedDatabase.buildingsTable;
  $FloorsTableTable get floorsTable => attachedDatabase.floorsTable;
  $RoomsTableTable get roomsTable => attachedDatabase.roomsTable;
  FloorDaoManager get managers => FloorDaoManager(this);
}

class FloorDaoManager {
  final _$FloorDaoMixin _db;
  FloorDaoManager(this._db);
  $$BuildingsTableTableTableManager get buildingsTable =>
      $$BuildingsTableTableTableManager(
        _db.attachedDatabase,
        _db.buildingsTable,
      );
  $$FloorsTableTableTableManager get floorsTable =>
      $$FloorsTableTableTableManager(_db.attachedDatabase, _db.floorsTable);
  $$RoomsTableTableTableManager get roomsTable =>
      $$RoomsTableTableTableManager(_db.attachedDatabase, _db.roomsTable);
}
