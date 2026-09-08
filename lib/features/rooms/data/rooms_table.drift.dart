// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:driftsql/features/rooms/data/rooms_table.drift.dart' as i1;
import 'package:driftsql/features/rooms/data/rooms_table.dart' as i2;
import 'package:drift/src/runtime/query_builder/query_builder.dart' as i3;
import 'package:driftsql/features/floors/data/floors_table.drift.dart' as i4;
import 'package:drift/internal/modular.dart' as i5;

typedef $$RoomsTableTableCreateCompanionBuilder =
    i1.RoomsTableCompanion Function({
      i0.Value<int> id,
      required int floorId,
      required String name,
      i0.Value<bool> isHeated,
      i0.Value<double?> targetTemperature,
      required double area,
      i0.Value<DateTime> createdAt,
    });
typedef $$RoomsTableTableUpdateCompanionBuilder =
    i1.RoomsTableCompanion Function({
      i0.Value<int> id,
      i0.Value<int> floorId,
      i0.Value<String> name,
      i0.Value<bool> isHeated,
      i0.Value<double?> targetTemperature,
      i0.Value<double> area,
      i0.Value<DateTime> createdAt,
    });

final class $$RoomsTableTableReferences
    extends
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.$RoomsTableTable,
          i1.RoomsTableData
        > {
  $$RoomsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static i4.$FloorsTableTable _floorIdTable(i0.GeneratedDatabase db) =>
      i5.ReadDatabaseContainer(db)
          .resultSet<i4.$FloorsTableTable>('floors_table')
          .createAlias('rooms_table__floor_id__floors_table__id');

  i4.$$FloorsTableTableProcessedTableManager get floorId {
    final $_column = $_itemColumn<int>('floor_id')!;

    final manager = i4
        .$$FloorsTableTableTableManager(
          $_db,
          i5.ReadDatabaseContainer(
            $_db,
          ).resultSet<i4.$FloorsTableTable>('floors_table'),
        )
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_floorIdTable($_db));
    if (item == null) return manager;
    return i0.ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RoomsTableTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$RoomsTableTable> {
  $$RoomsTableTableFilterComposer({
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

  i0.ColumnFilters<bool> get isHeated => $composableBuilder(
    column: $table.isHeated,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<double> get targetTemperature => $composableBuilder(
    column: $table.targetTemperature,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<double> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i4.$$FloorsTableTableFilterComposer get floorId {
    final i4.$$FloorsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.floorId,
      referencedTable: i5.ReadDatabaseContainer(
        $db,
      ).resultSet<i4.$FloorsTableTable>('floors_table'),
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => i4.$$FloorsTableTableFilterComposer(
            $db: $db,
            $table: i5.ReadDatabaseContainer(
              $db,
            ).resultSet<i4.$FloorsTableTable>('floors_table'),
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoomsTableTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$RoomsTableTable> {
  $$RoomsTableTableOrderingComposer({
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

  i0.ColumnOrderings<bool> get isHeated => $composableBuilder(
    column: $table.isHeated,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<double> get targetTemperature => $composableBuilder(
    column: $table.targetTemperature,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<double> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i4.$$FloorsTableTableOrderingComposer get floorId {
    final i4.$$FloorsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.floorId,
      referencedTable: i5.ReadDatabaseContainer(
        $db,
      ).resultSet<i4.$FloorsTableTable>('floors_table'),
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => i4.$$FloorsTableTableOrderingComposer(
            $db: $db,
            $table: i5.ReadDatabaseContainer(
              $db,
            ).resultSet<i4.$FloorsTableTable>('floors_table'),
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoomsTableTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$RoomsTableTable> {
  $$RoomsTableTableAnnotationComposer({
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

  i0.GeneratedColumn<bool> get isHeated =>
      $composableBuilder(column: $table.isHeated, builder: (column) => column);

  i0.GeneratedColumn<double> get targetTemperature => $composableBuilder(
    column: $table.targetTemperature,
    builder: (column) => column,
  );

  i0.GeneratedColumn<double> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  i4.$$FloorsTableTableAnnotationComposer get floorId {
    final i4.$$FloorsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.floorId,
      referencedTable: i5.ReadDatabaseContainer(
        $db,
      ).resultSet<i4.$FloorsTableTable>('floors_table'),
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => i4.$$FloorsTableTableAnnotationComposer(
            $db: $db,
            $table: i5.ReadDatabaseContainer(
              $db,
            ).resultSet<i4.$FloorsTableTable>('floors_table'),
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoomsTableTableTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.$RoomsTableTable,
          i1.RoomsTableData,
          i1.$$RoomsTableTableFilterComposer,
          i1.$$RoomsTableTableOrderingComposer,
          i1.$$RoomsTableTableAnnotationComposer,
          $$RoomsTableTableCreateCompanionBuilder,
          $$RoomsTableTableUpdateCompanionBuilder,
          (i1.RoomsTableData, i1.$$RoomsTableTableReferences),
          i1.RoomsTableData,
          i0.PrefetchHooks Function({bool floorId})
        > {
  $$RoomsTableTableTableManager(
    i0.GeneratedDatabase db,
    i1.$RoomsTableTable table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$RoomsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$RoomsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$$RoomsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<int> floorId = const i0.Value.absent(),
                i0.Value<String> name = const i0.Value.absent(),
                i0.Value<bool> isHeated = const i0.Value.absent(),
                i0.Value<double?> targetTemperature = const i0.Value.absent(),
                i0.Value<double> area = const i0.Value.absent(),
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
              }) => i1.RoomsTableCompanion(
                id: id,
                floorId: floorId,
                name: name,
                isHeated: isHeated,
                targetTemperature: targetTemperature,
                area: area,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required int floorId,
                required String name,
                i0.Value<bool> isHeated = const i0.Value.absent(),
                i0.Value<double?> targetTemperature = const i0.Value.absent(),
                required double area,
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
              }) => i1.RoomsTableCompanion.insert(
                id: id,
                floorId: floorId,
                name: name,
                isHeated: isHeated,
                targetTemperature: targetTemperature,
                area: area,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  i1.$$RoomsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({floorId = false}) {
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
                    if (floorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.floorId,
                                referencedTable: i1.$$RoomsTableTableReferences
                                    ._floorIdTable(db),
                                referencedColumn: i1.$$RoomsTableTableReferences
                                    ._floorIdTable(db)
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

typedef $$RoomsTableTableProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.$RoomsTableTable,
      i1.RoomsTableData,
      i1.$$RoomsTableTableFilterComposer,
      i1.$$RoomsTableTableOrderingComposer,
      i1.$$RoomsTableTableAnnotationComposer,
      $$RoomsTableTableCreateCompanionBuilder,
      $$RoomsTableTableUpdateCompanionBuilder,
      (i1.RoomsTableData, i1.$$RoomsTableTableReferences),
      i1.RoomsTableData,
      i0.PrefetchHooks Function({bool floorId})
    >;

class $RoomsTableTable extends i2.RoomsTable
    with i0.TableInfo<$RoomsTableTable, i1.RoomsTableData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoomsTableTable(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _floorIdMeta = const i0.VerificationMeta(
    'floorId',
  );
  @override
  late final i0.GeneratedColumn<int> floorId = i0.GeneratedColumn<int>(
    'floor_id',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'REFERENCES floors_table (id) ON DELETE CASCADE',
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
  static const i0.VerificationMeta _isHeatedMeta = const i0.VerificationMeta(
    'isHeated',
  );
  @override
  late final i0.GeneratedColumn<bool> isHeated = i0.GeneratedColumn<bool>(
    'is_heated',
    aliasedName,
    false,
    type: i0.DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'CHECK ("is_heated" IN (0, 1))',
    ),
    defaultValue: const i3.Constant(true),
  );
  static const i0.VerificationMeta _targetTemperatureMeta =
      const i0.VerificationMeta('targetTemperature');
  @override
  late final i0.GeneratedColumn<double> targetTemperature =
      i0.GeneratedColumn<double>(
        'target_temperature',
        aliasedName,
        true,
        type: i0.DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const i0.VerificationMeta _areaMeta = const i0.VerificationMeta(
    'area',
  );
  @override
  late final i0.GeneratedColumn<double> area = i0.GeneratedColumn<double>(
    'area',
    aliasedName,
    false,
    type: i0.DriftSqlType.double,
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
    floorId,
    name,
    isHeated,
    targetTemperature,
    area,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rooms_table';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.RoomsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('floor_id')) {
      context.handle(
        _floorIdMeta,
        floorId.isAcceptableOrUnknown(data['floor_id']!, _floorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_floorIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_heated')) {
      context.handle(
        _isHeatedMeta,
        isHeated.isAcceptableOrUnknown(data['is_heated']!, _isHeatedMeta),
      );
    }
    if (data.containsKey('target_temperature')) {
      context.handle(
        _targetTemperatureMeta,
        targetTemperature.isAcceptableOrUnknown(
          data['target_temperature']!,
          _targetTemperatureMeta,
        ),
      );
    }
    if (data.containsKey('area')) {
      context.handle(
        _areaMeta,
        area.isAcceptableOrUnknown(data['area']!, _areaMeta),
      );
    } else if (isInserting) {
      context.missing(_areaMeta);
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
  i1.RoomsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.RoomsTableData(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      floorId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}floor_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isHeated: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}is_heated'],
      )!,
      targetTemperature: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.double,
        data['${effectivePrefix}target_temperature'],
      ),
      area: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.double,
        data['${effectivePrefix}area'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RoomsTableTable createAlias(String alias) {
    return $RoomsTableTable(attachedDatabase, alias);
  }
}

class RoomsTableData extends i0.DataClass
    implements i0.Insertable<i1.RoomsTableData> {
  /// Odanın hangi kata ait olduğunu belirten Primary Key.
  final int id;

  /// Odanın hangi kata ait olduğunu belirten Foreign Key.
  ///
  /// rooms_table.floor_id
  ///          ↓
  /// floors_table.id
  ///
  /// Böylece Room ile Floor arasında gerçek
  /// ilişkisel database bağlantısı kurulmuş olur.
  final int floorId;

  /// Odanın adı.
  ///
  /// Örnek:
  /// Living Room
  /// Kitchen
  /// Bedroom
  final String name;

  /// Odanın ısıtılan bir alan olup olmadığını belirtir.
  final bool isHeated;

  /// Odanın hedef sıcaklığı.
  ///
  /// Örnek:
  /// Living Room = 20.0
  /// Bathroom = 24.0
  ///
  /// Isıtılmayan bir oda için null bırakılabileceği
  /// için nullable tanımlıyoruz.
  final double? targetTemperature;

  /// Odanın alanı, metrekare cinsinden.
  ///
  /// Örnek:
  /// 18.5 m²
  final double area;

  /// Kaydın local database'e ekleme zamanı.
  final DateTime createdAt;
  const RoomsTableData({
    required this.id,
    required this.floorId,
    required this.name,
    required this.isHeated,
    this.targetTemperature,
    required this.area,
    required this.createdAt,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['floor_id'] = i0.Variable<int>(floorId);
    map['name'] = i0.Variable<String>(name);
    map['is_heated'] = i0.Variable<bool>(isHeated);
    if (!nullToAbsent || targetTemperature != null) {
      map['target_temperature'] = i0.Variable<double>(targetTemperature);
    }
    map['area'] = i0.Variable<double>(area);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    return map;
  }

  i1.RoomsTableCompanion toCompanion(bool nullToAbsent) {
    return i1.RoomsTableCompanion(
      id: i0.Value(id),
      floorId: i0.Value(floorId),
      name: i0.Value(name),
      isHeated: i0.Value(isHeated),
      targetTemperature: targetTemperature == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(targetTemperature),
      area: i0.Value(area),
      createdAt: i0.Value(createdAt),
    );
  }

  factory RoomsTableData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return RoomsTableData(
      id: serializer.fromJson<int>(json['id']),
      floorId: serializer.fromJson<int>(json['floorId']),
      name: serializer.fromJson<String>(json['name']),
      isHeated: serializer.fromJson<bool>(json['isHeated']),
      targetTemperature: serializer.fromJson<double?>(
        json['targetTemperature'],
      ),
      area: serializer.fromJson<double>(json['area']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'floorId': serializer.toJson<int>(floorId),
      'name': serializer.toJson<String>(name),
      'isHeated': serializer.toJson<bool>(isHeated),
      'targetTemperature': serializer.toJson<double?>(targetTemperature),
      'area': serializer.toJson<double>(area),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  i1.RoomsTableData copyWith({
    int? id,
    int? floorId,
    String? name,
    bool? isHeated,
    i0.Value<double?> targetTemperature = const i0.Value.absent(),
    double? area,
    DateTime? createdAt,
  }) => i1.RoomsTableData(
    id: id ?? this.id,
    floorId: floorId ?? this.floorId,
    name: name ?? this.name,
    isHeated: isHeated ?? this.isHeated,
    targetTemperature: targetTemperature.present
        ? targetTemperature.value
        : this.targetTemperature,
    area: area ?? this.area,
    createdAt: createdAt ?? this.createdAt,
  );
  RoomsTableData copyWithCompanion(i1.RoomsTableCompanion data) {
    return RoomsTableData(
      id: data.id.present ? data.id.value : this.id,
      floorId: data.floorId.present ? data.floorId.value : this.floorId,
      name: data.name.present ? data.name.value : this.name,
      isHeated: data.isHeated.present ? data.isHeated.value : this.isHeated,
      targetTemperature: data.targetTemperature.present
          ? data.targetTemperature.value
          : this.targetTemperature,
      area: data.area.present ? data.area.value : this.area,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoomsTableData(')
          ..write('id: $id, ')
          ..write('floorId: $floorId, ')
          ..write('name: $name, ')
          ..write('isHeated: $isHeated, ')
          ..write('targetTemperature: $targetTemperature, ')
          ..write('area: $area, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    floorId,
    name,
    isHeated,
    targetTemperature,
    area,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.RoomsTableData &&
          other.id == this.id &&
          other.floorId == this.floorId &&
          other.name == this.name &&
          other.isHeated == this.isHeated &&
          other.targetTemperature == this.targetTemperature &&
          other.area == this.area &&
          other.createdAt == this.createdAt);
}

class RoomsTableCompanion extends i0.UpdateCompanion<i1.RoomsTableData> {
  final i0.Value<int> id;
  final i0.Value<int> floorId;
  final i0.Value<String> name;
  final i0.Value<bool> isHeated;
  final i0.Value<double?> targetTemperature;
  final i0.Value<double> area;
  final i0.Value<DateTime> createdAt;
  const RoomsTableCompanion({
    this.id = const i0.Value.absent(),
    this.floorId = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.isHeated = const i0.Value.absent(),
    this.targetTemperature = const i0.Value.absent(),
    this.area = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
  });
  RoomsTableCompanion.insert({
    this.id = const i0.Value.absent(),
    required int floorId,
    required String name,
    this.isHeated = const i0.Value.absent(),
    this.targetTemperature = const i0.Value.absent(),
    required double area,
    this.createdAt = const i0.Value.absent(),
  }) : floorId = i0.Value(floorId),
       name = i0.Value(name),
       area = i0.Value(area);
  static i0.Insertable<i1.RoomsTableData> custom({
    i0.Expression<int>? id,
    i0.Expression<int>? floorId,
    i0.Expression<String>? name,
    i0.Expression<bool>? isHeated,
    i0.Expression<double>? targetTemperature,
    i0.Expression<double>? area,
    i0.Expression<DateTime>? createdAt,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (floorId != null) 'floor_id': floorId,
      if (name != null) 'name': name,
      if (isHeated != null) 'is_heated': isHeated,
      if (targetTemperature != null) 'target_temperature': targetTemperature,
      if (area != null) 'area': area,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  i1.RoomsTableCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<int>? floorId,
    i0.Value<String>? name,
    i0.Value<bool>? isHeated,
    i0.Value<double?>? targetTemperature,
    i0.Value<double>? area,
    i0.Value<DateTime>? createdAt,
  }) {
    return i1.RoomsTableCompanion(
      id: id ?? this.id,
      floorId: floorId ?? this.floorId,
      name: name ?? this.name,
      isHeated: isHeated ?? this.isHeated,
      targetTemperature: targetTemperature ?? this.targetTemperature,
      area: area ?? this.area,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (floorId.present) {
      map['floor_id'] = i0.Variable<int>(floorId.value);
    }
    if (name.present) {
      map['name'] = i0.Variable<String>(name.value);
    }
    if (isHeated.present) {
      map['is_heated'] = i0.Variable<bool>(isHeated.value);
    }
    if (targetTemperature.present) {
      map['target_temperature'] = i0.Variable<double>(targetTemperature.value);
    }
    if (area.present) {
      map['area'] = i0.Variable<double>(area.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoomsTableCompanion(')
          ..write('id: $id, ')
          ..write('floorId: $floorId, ')
          ..write('name: $name, ')
          ..write('isHeated: $isHeated, ')
          ..write('targetTemperature: $targetTemperature, ')
          ..write('area: $area, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}
