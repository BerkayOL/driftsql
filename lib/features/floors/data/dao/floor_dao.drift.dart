// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:driftsql/core/database/app_database.dart' as i1;
import 'package:driftsql/features/buildings/data/buildings_table.drift.dart'
    as i2;
import 'package:drift/internal/modular.dart' as i3;
import 'package:driftsql/features/floors/data/floors_table.drift.dart' as i4;
import 'package:driftsql/features/rooms/data/rooms_table.drift.dart' as i5;

mixin $FloorDaoMixin on i0.DatabaseAccessor<i1.AppDatabase> {
  i2.$BuildingsTableTable get buildingsTable => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i2.$BuildingsTableTable>('buildings_table');
  i4.$FloorsTableTable get floorsTable => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i4.$FloorsTableTable>('floors_table');
  i5.$RoomsTableTable get roomsTable => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i5.$RoomsTableTable>('rooms_table');
  FloorDaoManager get managers => FloorDaoManager(this);
}

class FloorDaoManager {
  final $FloorDaoMixin _db;
  FloorDaoManager(this._db);
  i2.$$BuildingsTableTableTableManager get buildingsTable =>
      i2.$$BuildingsTableTableTableManager(
        _db.attachedDatabase,
        _db.buildingsTable,
      );
  i4.$$FloorsTableTableTableManager get floorsTable =>
      i4.$$FloorsTableTableTableManager(_db.attachedDatabase, _db.floorsTable);
  i5.$$RoomsTableTableTableManager get roomsTable =>
      i5.$$RoomsTableTableTableManager(_db.attachedDatabase, _db.roomsTable);
}
