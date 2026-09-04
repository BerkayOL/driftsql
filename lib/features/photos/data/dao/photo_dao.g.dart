// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_dao.dart';

// ignore_for_file: type=lint
mixin _$PhotoDaoMixin on DatabaseAccessor<AppDatabase> {
  $BuildingsTableTable get buildingsTable => attachedDatabase.buildingsTable;
  $FloorsTableTable get floorsTable => attachedDatabase.floorsTable;
  $RoomsTableTable get roomsTable => attachedDatabase.roomsTable;
  $OfflinePhotosTableTable get offlinePhotosTable =>
      attachedDatabase.offlinePhotosTable;
  PhotoDaoManager get managers => PhotoDaoManager(this);
}

class PhotoDaoManager {
  final _$PhotoDaoMixin _db;
  PhotoDaoManager(this._db);
  $$BuildingsTableTableTableManager get buildingsTable =>
      $$BuildingsTableTableTableManager(
        _db.attachedDatabase,
        _db.buildingsTable,
      );
  $$FloorsTableTableTableManager get floorsTable =>
      $$FloorsTableTableTableManager(_db.attachedDatabase, _db.floorsTable);
  $$RoomsTableTableTableManager get roomsTable =>
      $$RoomsTableTableTableManager(_db.attachedDatabase, _db.roomsTable);
  $$OfflinePhotosTableTableTableManager get offlinePhotosTable =>
      $$OfflinePhotosTableTableTableManager(
        _db.attachedDatabase,
        _db.offlinePhotosTable,
      );
}
