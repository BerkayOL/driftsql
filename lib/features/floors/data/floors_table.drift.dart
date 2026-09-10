// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:driftsql/features/floors/data/floors_table.drift.dart' as i1;
import 'package:driftsql/features/floors/data/floors_table.dart' as i2;
import 'package:drift/src/runtime/query_builder/query_builder.dart' as i3;
import 'package:driftsql/features/buildings/data/buildings_table.drift.dart'
    as i4;
import 'package:drift/internal/modular.dart' as i5;

typedef $$FloorsTableTableCreateCompanionBuilder =
    i1.FloorsTableCompanion Function({
      i0.Value<int> id,
      required int buildingId,
      required String name,
      required int floorNumber,
      i0.Value<DateTime> createdAt,
    });
typedef $$FloorsTableTableUpdateCompanionBuilder =
    i1.FloorsTableCompanion Function({
      i0.Value<int> id,
      i0.Value<int> buildingId,
      i0.Value<String> name,
      i0.Value<int> floorNumber,
      i0.Value<DateTime> createdAt,
    });

final class $$FloorsTableTableReferences
    extends
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.$FloorsTableTable,
          i1.FloorsTableData
        > {
  $$FloorsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static i4.$BuildingsTableTable _buildingIdTable(i0.GeneratedDatabase db) =>
      i5.ReadDatabaseContainer(db)
          .resultSet<i4.$BuildingsTableTable>('buildings_table')
          .createAlias('floors_table__building_id__buildings_table__id');

  i4.$$BuildingsTableTableProcessedTableManager get buildingId {
    final $_column = $_itemColumn<int>('building_id')!;

    final manager = i4
        .$$BuildingsTableTableTableManager(
          $_db,
          i5.ReadDatabaseContainer(
            $_db,
          ).resultSet<i4.$BuildingsTableTable>('buildings_table'),
        )
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_buildingIdTable($_db));
    if (item == null) return manager;
    return i0.ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FloorsTableTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$FloorsTableTable> {
  $$FloorsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get floorNumber => $composableBuilder(
    column: $table.floorNumber,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i4.$$BuildingsTableTableFilterComposer get buildingId {
    final i4.$$BuildingsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.buildingId,
      referencedTable: i5.ReadDatabaseContainer(
        $db,
      ).resultSet<i4.$BuildingsTableTable>('buildings_table'),
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => i4.$$BuildingsTableTableFilterComposer(
            $db: $db,
            $table: i5.ReadDatabaseContainer(
              $db,
            ).resultSet<i4.$BuildingsTableTable>('buildings_table'),
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FloorsTableTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$FloorsTableTable> {
  $$FloorsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get floorNumber => $composableBuilder(
    column: $table.floorNumber,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i4.$$BuildingsTableTableOrderingComposer get buildingId {
    final i4.$$BuildingsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.buildingId,
      referencedTable: i5.ReadDatabaseContainer(
        $db,
      ).resultSet<i4.$BuildingsTableTable>('buildings_table'),
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => i4.$$BuildingsTableTableOrderingComposer(
            $db: $db,
            $table: i5.ReadDatabaseContainer(
              $db,
            ).resultSet<i4.$BuildingsTableTable>('buildings_table'),
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FloorsTableTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$FloorsTableTable> {
  $$FloorsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  i0.GeneratedColumn<int> get floorNumber => $composableBuilder(
    column: $table.floorNumber,
    builder: (column) => column,
  );

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  i4.$$BuildingsTableTableAnnotationComposer get buildingId {
    final i4.$$BuildingsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.buildingId,
          referencedTable: i5.ReadDatabaseContainer(
            $db,
          ).resultSet<i4.$BuildingsTableTable>('buildings_table'),
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => i4.$$BuildingsTableTableAnnotationComposer(
                $db: $db,
                $table: i5.ReadDatabaseContainer(
                  $db,
                ).resultSet<i4.$BuildingsTableTable>('buildings_table'),
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$FloorsTableTableTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.$FloorsTableTable,
          i1.FloorsTableData,
          i1.$$FloorsTableTableFilterComposer,
          i1.$$FloorsTableTableOrderingComposer,
          i1.$$FloorsTableTableAnnotationComposer,
          $$FloorsTableTableCreateCompanionBuilder,
          $$FloorsTableTableUpdateCompanionBuilder,
          (i1.FloorsTableData, i1.$$FloorsTableTableReferences),
          i1.FloorsTableData,
          i0.PrefetchHooks Function({bool buildingId})
        > {
  $$FloorsTableTableTableManager(
    i0.GeneratedDatabase db,
    i1.$FloorsTableTable table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$FloorsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$FloorsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$$FloorsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<int> buildingId = const i0.Value.absent(),
                i0.Value<String> name = const i0.Value.absent(),
                i0.Value<int> floorNumber = const i0.Value.absent(),
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
              }) => i1.FloorsTableCompanion(
                id: id,
                buildingId: buildingId,
                name: name,
                floorNumber: floorNumber,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required int buildingId,
                required String name,
                required int floorNumber,
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
              }) => i1.FloorsTableCompanion.insert(
                id: id,
                buildingId: buildingId,
                name: name,
                floorNumber: floorNumber,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  i1.$$FloorsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({buildingId = false}) {
            return i0.PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends i0.TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (buildingId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.buildingId,
                                referencedTable: i1.$$FloorsTableTableReferences
                                    ._buildingIdTable(db),
                                referencedColumn: i1
                                    .$$FloorsTableTableReferences
                                    ._buildingIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FloorsTableTableProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.$FloorsTableTable,
      i1.FloorsTableData,
      i1.$$FloorsTableTableFilterComposer,
      i1.$$FloorsTableTableOrderingComposer,
      i1.$$FloorsTableTableAnnotationComposer,
      $$FloorsTableTableCreateCompanionBuilder,
      $$FloorsTableTableUpdateCompanionBuilder,
      (i1.FloorsTableData, i1.$$FloorsTableTableReferences),
      i1.FloorsTableData,
      i0.PrefetchHooks Function({bool buildingId})
    >;
i0.Index get idxFloorsBuildingFloorNumber => i0.Index(
  'idx_floors_building_floor_number',
  'CREATE UNIQUE INDEX idx_floors_building_floor_number ON floors_table (building_id, floor_number)',
);

class $FloorsTableTable extends i2.FloorsTable
    with i0.TableInfo<$FloorsTableTable, i1.FloorsTableData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FloorsTableTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const i0.VerificationMeta _buildingIdMeta = const i0.VerificationMeta(
    'buildingId',
  );
  @override
  late final i0.GeneratedColumn<int> buildingId = i0.GeneratedColumn<int>(
    'building_id',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'REFERENCES buildings_table (id) ON DELETE CASCADE',
    ),
  );
  static const i0.VerificationMeta _nameMeta = const i0.VerificationMeta(
    'name',
  );
  @override
  late final i0.GeneratedColumn<String> name = i0.GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _floorNumberMeta = const i0.VerificationMeta(
    'floorNumber',
  );
  @override
  late final i0.GeneratedColumn<int> floorNumber = i0.GeneratedColumn<int>(
    'floor_number',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _createdAtMeta = const i0.VerificationMeta(
    'createdAt',
  );
  @override
  late final i0.GeneratedColumn<DateTime> createdAt =
      i0.GeneratedColumn<DateTime>(
        'created_at',
        aliasedName,
        false,
        type: i0.DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: i3.currentDateAndTime,
      );
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    buildingId,
    name,
    floorNumber,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'floors_table';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.FloorsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('building_id')) {
      context.handle(
        _buildingIdMeta,
        buildingId.isAcceptableOrUnknown(data['building_id']!, _buildingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_buildingIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('floor_number')) {
      context.handle(
        _floorNumberMeta,
        floorNumber.isAcceptableOrUnknown(
          data['floor_number']!,
          _floorNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_floorNumberMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.FloorsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.FloorsTableData(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      buildingId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}building_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      floorNumber: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}floor_number'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FloorsTableTable createAlias(String alias) {
    return $FloorsTableTable(attachedDatabase, alias);
  }
}

class FloorsTableData extends i0.DataClass
    implements i0.Insertable<i1.FloorsTableData> {
  /// Her katın benzersiz ID'si.
  final int id;

  /// Bu katın hangi binaya ait olduğunu belirtir.
  ///
  /// Foreign Key:
  ///
  /// floors_table.building_id
  ///             ↓
  /// buildings_table.id
  ///
  /// Böylece kat ile bina arasında gerçek bir
  /// database ilişkisi kurmuş oluyoruz.
  final int buildingId;

  /// Katın adı.
  ///
  /// Örnek:
  /// Basement
  /// Ground Floor
  /// First Floor
  final String name;

  /// Kat numarası.
  ///
  /// Örneğin:
  /// Bodrum = -1
  /// Zemin = 0
  /// 1. Kat = 1
  /// 2. Kat = 2
  final int floorNumber;

  /// Kaydın oluşturulma zamanı.
  final DateTime createdAt;
  const FloorsTableData({
    required this.id,
    required this.buildingId,
    required this.name,
    required this.floorNumber,
    required this.createdAt,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['building_id'] = i0.Variable<int>(buildingId);
    map['name'] = i0.Variable<String>(name);
    map['floor_number'] = i0.Variable<int>(floorNumber);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    return map;
  }

  i1.FloorsTableCompanion toCompanion(bool nullToAbsent) {
    return i1.FloorsTableCompanion(
      id: i0.Value(id),
      buildingId: i0.Value(buildingId),
      name: i0.Value(name),
      floorNumber: i0.Value(floorNumber),
      createdAt: i0.Value(createdAt),
    );
  }

  factory FloorsTableData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return FloorsTableData(
      id: serializer.fromJson<int>(json['id']),
      buildingId: serializer.fromJson<int>(json['buildingId']),
      name: serializer.fromJson<String>(json['name']),
      floorNumber: serializer.fromJson<int>(json['floorNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'buildingId': serializer.toJson<int>(buildingId),
      'name': serializer.toJson<String>(name),
      'floorNumber': serializer.toJson<int>(floorNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  i1.FloorsTableData copyWith({
    int? id,
    int? buildingId,
    String? name,
    int? floorNumber,
    DateTime? createdAt,
  }) => i1.FloorsTableData(
    id: id ?? this.id,
    buildingId: buildingId ?? this.buildingId,
    name: name ?? this.name,
    floorNumber: floorNumber ?? this.floorNumber,
    createdAt: createdAt ?? this.createdAt,
  );
  FloorsTableData copyWithCompanion(i1.FloorsTableCompanion data) {
    return FloorsTableData(
      id: data.id.present ? data.id.value : this.id,
      buildingId: data.buildingId.present
          ? data.buildingId.value
          : this.buildingId,
      name: data.name.present ? data.name.value : this.name,
      floorNumber: data.floorNumber.present
          ? data.floorNumber.value
          : this.floorNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FloorsTableData(')
          ..write('id: $id, ')
          ..write('buildingId: $buildingId, ')
          ..write('name: $name, ')
          ..write('floorNumber: $floorNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, buildingId, name, floorNumber, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.FloorsTableData &&
          other.id == this.id &&
          other.buildingId == this.buildingId &&
          other.name == this.name &&
          other.floorNumber == this.floorNumber &&
          other.createdAt == this.createdAt);
}

class FloorsTableCompanion extends i0.UpdateCompanion<i1.FloorsTableData> {
  final i0.Value<int> id;
  final i0.Value<int> buildingId;
  final i0.Value<String> name;
  final i0.Value<int> floorNumber;
  final i0.Value<DateTime> createdAt;
  const FloorsTableCompanion({
    this.id = const i0.Value.absent(),
    this.buildingId = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.floorNumber = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
  });
  FloorsTableCompanion.insert({
    this.id = const i0.Value.absent(),
    required int buildingId,
    required String name,
    required int floorNumber,
    this.createdAt = const i0.Value.absent(),
  }) : buildingId = i0.Value(buildingId),
       name = i0.Value(name),
       floorNumber = i0.Value(floorNumber);
  static i0.Insertable<i1.FloorsTableData> custom({
    i0.Expression<int>? id,
    i0.Expression<int>? buildingId,
    i0.Expression<String>? name,
    i0.Expression<int>? floorNumber,
    i0.Expression<DateTime>? createdAt,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (buildingId != null) 'building_id': buildingId,
      if (name != null) 'name': name,
      if (floorNumber != null) 'floor_number': floorNumber,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  i1.FloorsTableCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<int>? buildingId,
    i0.Value<String>? name,
    i0.Value<int>? floorNumber,
    i0.Value<DateTime>? createdAt,
  }) {
    return i1.FloorsTableCompanion(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      name: name ?? this.name,
      floorNumber: floorNumber ?? this.floorNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (buildingId.present) {
      map['building_id'] = i0.Variable<int>(buildingId.value);
    }
    if (name.present) {
      map['name'] = i0.Variable<String>(name.value);
    }
    if (floorNumber.present) {
      map['floor_number'] = i0.Variable<int>(floorNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FloorsTableCompanion(')
          ..write('id: $id, ')
          ..write('buildingId: $buildingId, ')
          ..write('name: $name, ')
          ..write('floorNumber: $floorNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}
