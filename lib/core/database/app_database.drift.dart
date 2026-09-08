// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:driftsql/features/buildings/data/buildings_table.drift.dart'
    as i1;
import 'package:driftsql/features/floors/data/floors_table.drift.dart' as i2;
import 'package:driftsql/features/rooms/data/rooms_table.drift.dart' as i3;
import 'package:driftsql/features/photos/data/offline_photos_table.drift.dart'
    as i4;
import 'package:driftsql/features/photos/data/dao/photo_dao.dart' as i5;
import 'package:driftsql/core/database/app_database.dart' as i6;
import 'package:driftsql/features/buildings/data/dao/building_dao.dart' as i7;
import 'package:driftsql/features/floors/data/dao/floor_dao.dart' as i8;
import 'package:driftsql/features/rooms/data/dao/room_dao.dart' as i9;

abstract class $AppDatabase extends i0.GeneratedDatabase {
  $AppDatabase(i0.QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final i1.$BuildingsTableTable buildingsTable = i1.$BuildingsTableTable(
    this,
  );
  late final i2.$FloorsTableTable floorsTable = i2.$FloorsTableTable(this);
  late final i3.$RoomsTableTable roomsTable = i3.$RoomsTableTable(this);
  late final i4.$OfflinePhotosTableTable offlinePhotosTable = i4
      .$OfflinePhotosTableTable(this);
  late final i5.PhotoDao photoDao = i5.PhotoDao(this as i6.AppDatabase);
  late final i7.BuildingDao buildingDao = i7.BuildingDao(
    this as i6.AppDatabase,
  );
  late final i8.FloorDao floorDao = i8.FloorDao(this as i6.AppDatabase);
  late final i9.RoomDao roomDao = i9.RoomDao(this as i6.AppDatabase);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
    buildingsTable,
    floorsTable,
    roomsTable,
    offlinePhotosTable,
  ];
  @override
  i0.StreamQueryUpdateRules get streamUpdateRules =>
      const i0.StreamQueryUpdateRules([
        i0.WritePropagation(
          on: i0.TableUpdateQuery.onTableName(
            'buildings_table',
            limitUpdateKind: i0.UpdateKind.delete,
          ),
          result: [i0.TableUpdate('floors_table', kind: i0.UpdateKind.delete)],
        ),
        i0.WritePropagation(
          on: i0.TableUpdateQuery.onTableName(
            'floors_table',
            limitUpdateKind: i0.UpdateKind.delete,
          ),
          result: [i0.TableUpdate('rooms_table', kind: i0.UpdateKind.delete)],
        ),
        i0.WritePropagation(
          on: i0.TableUpdateQuery.onTableName(
            'rooms_table',
            limitUpdateKind: i0.UpdateKind.delete,
          ),
          result: [
            i0.TableUpdate('offline_photos_table', kind: i0.UpdateKind.update),
          ],
        ),
      ]);
}

class $AppDatabaseManager {
  final $AppDatabase _db;
  $AppDatabaseManager(this._db);
  i1.$$BuildingsTableTableTableManager get buildingsTable =>
      i1.$$BuildingsTableTableTableManager(_db, _db.buildingsTable);
  i2.$$FloorsTableTableTableManager get floorsTable =>
      i2.$$FloorsTableTableTableManager(_db, _db.floorsTable);
  i3.$$RoomsTableTableTableManager get roomsTable =>
      i3.$$RoomsTableTableTableManager(_db, _db.roomsTable);
  i4.$$OfflinePhotosTableTableTableManager get offlinePhotosTable =>
      i4.$$OfflinePhotosTableTableTableManager(_db, _db.offlinePhotosTable);
}
