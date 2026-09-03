// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_dao.dart';

// ignore_for_file: type=lint
mixin _$PhotoDaoMixin on DatabaseAccessor<AppDatabase> {
  $OfflinePhotosTableTable get offlinePhotosTable =>
      attachedDatabase.offlinePhotosTable;
  PhotoDaoManager get managers => PhotoDaoManager(this);
}

class PhotoDaoManager {
  final _$PhotoDaoMixin _db;
  PhotoDaoManager(this._db);
  $$OfflinePhotosTableTableTableManager get offlinePhotosTable =>
      $$OfflinePhotosTableTableTableManager(
        _db.attachedDatabase,
        _db.offlinePhotosTable,
      );
}
