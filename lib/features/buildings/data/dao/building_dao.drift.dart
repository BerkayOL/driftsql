// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:driftsql/core/database/app_database.dart' as i1;
import 'package:driftsql/features/buildings/data/buildings_table.drift.dart'
    as i2;
import 'package:drift/internal/modular.dart' as i3;

mixin $BuildingDaoMixin on i0.DatabaseAccessor<i1.AppDatabase> {
  i2.$BuildingsTableTable get buildingsTable => i3.ReadDatabaseContainer(
    attachedDatabase,
  ).resultSet<i2.$BuildingsTableTable>('buildings_table');
  BuildingDaoManager get managers => BuildingDaoManager(this);
}

class BuildingDaoManager {
  final $BuildingDaoMixin _db;
  BuildingDaoManager(this._db);
  i2.$$BuildingsTableTableTableManager get buildingsTable =>
      i2.$$BuildingsTableTableTableManager(
        _db.attachedDatabase,
        _db.buildingsTable,
      );
}
