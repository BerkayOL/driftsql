// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_dao.dart';

// ignore_for_file: type=lint
mixin _$RoomDaoMixin on DatabaseAccessor<AppDatabase> {
  $BuildingsTableTable get buildingsTable => attachedDatabase.buildingsTable;
  $FloorsTableTable get floorsTable => attachedDatabase.floorsTable;
  $RoomsTableTable get roomsTable => attachedDatabase.roomsTable;
  RoomDaoManager get managers => RoomDaoManager(this);
}

class RoomDaoManager {
  final _$RoomDaoMixin _db;
  RoomDaoManager(this._db);
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
