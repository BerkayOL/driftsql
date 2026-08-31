// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $OfflinePhotosTableTable extends OfflinePhotosTable
    with TableInfo<$OfflinePhotosTableTable, OfflinePhotosTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OfflinePhotosTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, imagePath, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'offline_photos_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<OfflinePhotosTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OfflinePhotosTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OfflinePhotosTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $OfflinePhotosTableTable createAlias(String alias) {
    return $OfflinePhotosTableTable(attachedDatabase, alias);
  }
}

class OfflinePhotosTableData extends DataClass
    implements Insertable<OfflinePhotosTableData> {
  final int id;
  final String imagePath;
  final DateTime createdAt;
  const OfflinePhotosTableData({
    required this.id,
    required this.imagePath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['image_path'] = Variable<String>(imagePath);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OfflinePhotosTableCompanion toCompanion(bool nullToAbsent) {
    return OfflinePhotosTableCompanion(
      id: Value(id),
      imagePath: Value(imagePath),
      createdAt: Value(createdAt),
    );
  }

  factory OfflinePhotosTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OfflinePhotosTableData(
      id: serializer.fromJson<int>(json['id']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imagePath': serializer.toJson<String>(imagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OfflinePhotosTableData copyWith({
    int? id,
    String? imagePath,
    DateTime? createdAt,
  }) => OfflinePhotosTableData(
    id: id ?? this.id,
    imagePath: imagePath ?? this.imagePath,
    createdAt: createdAt ?? this.createdAt,
  );
  OfflinePhotosTableData copyWithCompanion(OfflinePhotosTableCompanion data) {
    return OfflinePhotosTableData(
      id: data.id.present ? data.id.value : this.id,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OfflinePhotosTableData(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imagePath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OfflinePhotosTableData &&
          other.id == this.id &&
          other.imagePath == this.imagePath &&
          other.createdAt == this.createdAt);
}

class OfflinePhotosTableCompanion
    extends UpdateCompanion<OfflinePhotosTableData> {
  final Value<int> id;
  final Value<String> imagePath;
  final Value<DateTime> createdAt;
  const OfflinePhotosTableCompanion({
    this.id = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  OfflinePhotosTableCompanion.insert({
    this.id = const Value.absent(),
    required String imagePath,
    this.createdAt = const Value.absent(),
  }) : imagePath = Value(imagePath);
  static Insertable<OfflinePhotosTableData> custom({
    Expression<int>? id,
    Expression<String>? imagePath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imagePath != null) 'image_path': imagePath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  OfflinePhotosTableCompanion copyWith({
    Value<int>? id,
    Value<String>? imagePath,
    Value<DateTime>? createdAt,
  }) {
    return OfflinePhotosTableCompanion(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OfflinePhotosTableCompanion(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OfflinePhotosTableTable offlinePhotosTable =
      $OfflinePhotosTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [offlinePhotosTable];
}

typedef $$OfflinePhotosTableTableCreateCompanionBuilder =
    OfflinePhotosTableCompanion Function({
      Value<int> id,
      required String imagePath,
      Value<DateTime> createdAt,
    });
typedef $$OfflinePhotosTableTableUpdateCompanionBuilder =
    OfflinePhotosTableCompanion Function({
      Value<int> id,
      Value<String> imagePath,
      Value<DateTime> createdAt,
    });

class $$OfflinePhotosTableTableFilterComposer
    extends Composer<_$AppDatabase, $OfflinePhotosTableTable> {
  $$OfflinePhotosTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OfflinePhotosTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OfflinePhotosTableTable> {
  $$OfflinePhotosTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OfflinePhotosTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OfflinePhotosTableTable> {
  $$OfflinePhotosTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$OfflinePhotosTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OfflinePhotosTableTable,
          OfflinePhotosTableData,
          $$OfflinePhotosTableTableFilterComposer,
          $$OfflinePhotosTableTableOrderingComposer,
          $$OfflinePhotosTableTableAnnotationComposer,
          $$OfflinePhotosTableTableCreateCompanionBuilder,
          $$OfflinePhotosTableTableUpdateCompanionBuilder,
          (
            OfflinePhotosTableData,
            BaseReferences<
              _$AppDatabase,
              $OfflinePhotosTableTable,
              OfflinePhotosTableData
            >,
          ),
          OfflinePhotosTableData,
          PrefetchHooks Function()
        > {
  $$OfflinePhotosTableTableTableManager(
    _$AppDatabase db,
    $OfflinePhotosTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OfflinePhotosTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OfflinePhotosTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OfflinePhotosTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => OfflinePhotosTableCompanion(
                id: id,
                imagePath: imagePath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String imagePath,
                Value<DateTime> createdAt = const Value.absent(),
              }) => OfflinePhotosTableCompanion.insert(
                id: id,
                imagePath: imagePath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OfflinePhotosTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OfflinePhotosTableTable,
      OfflinePhotosTableData,
      $$OfflinePhotosTableTableFilterComposer,
      $$OfflinePhotosTableTableOrderingComposer,
      $$OfflinePhotosTableTableAnnotationComposer,
      $$OfflinePhotosTableTableCreateCompanionBuilder,
      $$OfflinePhotosTableTableUpdateCompanionBuilder,
      (
        OfflinePhotosTableData,
        BaseReferences<
          _$AppDatabase,
          $OfflinePhotosTableTable,
          OfflinePhotosTableData
        >,
      ),
      OfflinePhotosTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OfflinePhotosTableTableTableManager get offlinePhotosTable =>
      $$OfflinePhotosTableTableTableManager(_db, _db.offlinePhotosTable);
}
