// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:driftsql/features/photos/data/pending_file_cleanup_table.drift.dart'
    as i1;
import 'package:driftsql/features/photos/data/pending_file_cleanup_table.dart'
    as i2;
import 'package:drift/src/runtime/query_builder/query_builder.dart' as i3;

typedef $$PendingFileCleanupTableTableCreateCompanionBuilder =
    i1.PendingFileCleanupTableCompanion Function({
      i0.Value<int> id,
      required String filePath,
      i0.Value<DateTime> createdAt,
    });
typedef $$PendingFileCleanupTableTableUpdateCompanionBuilder =
    i1.PendingFileCleanupTableCompanion Function({
      i0.Value<int> id,
      i0.Value<String> filePath,
      i0.Value<DateTime> createdAt,
    });

class $$PendingFileCleanupTableTableFilterComposer
    extends
        i0.Composer<i0.GeneratedDatabase, i1.$PendingFileCleanupTableTable> {
  $$PendingFileCleanupTableTableFilterComposer({
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

  i0.ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $$PendingFileCleanupTableTableOrderingComposer
    extends
        i0.Composer<i0.GeneratedDatabase, i1.$PendingFileCleanupTableTable> {
  $$PendingFileCleanupTableTableOrderingComposer({
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

  i0.ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $$PendingFileCleanupTableTableAnnotationComposer
    extends
        i0.Composer<i0.GeneratedDatabase, i1.$PendingFileCleanupTableTable> {
  $$PendingFileCleanupTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PendingFileCleanupTableTableTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.$PendingFileCleanupTableTable,
          i1.PendingFileCleanupTableData,
          i1.$$PendingFileCleanupTableTableFilterComposer,
          i1.$$PendingFileCleanupTableTableOrderingComposer,
          i1.$$PendingFileCleanupTableTableAnnotationComposer,
          $$PendingFileCleanupTableTableCreateCompanionBuilder,
          $$PendingFileCleanupTableTableUpdateCompanionBuilder,
          (
            i1.PendingFileCleanupTableData,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.$PendingFileCleanupTableTable,
              i1.PendingFileCleanupTableData
            >,
          ),
          i1.PendingFileCleanupTableData,
          i0.PrefetchHooks Function()
        > {
  $$PendingFileCleanupTableTableTableManager(
    i0.GeneratedDatabase db,
    i1.$PendingFileCleanupTableTable table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$PendingFileCleanupTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              i1.$$PendingFileCleanupTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              i1.$$PendingFileCleanupTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<String> filePath = const i0.Value.absent(),
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
              }) => i1.PendingFileCleanupTableCompanion(
                id: id,
                filePath: filePath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required String filePath,
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
              }) => i1.PendingFileCleanupTableCompanion.insert(
                id: id,
                filePath: filePath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingFileCleanupTableTableProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.$PendingFileCleanupTableTable,
      i1.PendingFileCleanupTableData,
      i1.$$PendingFileCleanupTableTableFilterComposer,
      i1.$$PendingFileCleanupTableTableOrderingComposer,
      i1.$$PendingFileCleanupTableTableAnnotationComposer,
      $$PendingFileCleanupTableTableCreateCompanionBuilder,
      $$PendingFileCleanupTableTableUpdateCompanionBuilder,
      (
        i1.PendingFileCleanupTableData,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.$PendingFileCleanupTableTable,
          i1.PendingFileCleanupTableData
        >,
      ),
      i1.PendingFileCleanupTableData,
      i0.PrefetchHooks Function()
    >;

class $PendingFileCleanupTableTable extends i2.PendingFileCleanupTable
    with
        i0.TableInfo<
          $PendingFileCleanupTableTable,
          i1.PendingFileCleanupTableData
        > {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingFileCleanupTableTable(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _filePathMeta = const i0.VerificationMeta(
    'filePath',
  );
  @override
  late final i0.GeneratedColumn<String> filePath = i0.GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways('UNIQUE'),
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
  List<i0.GeneratedColumn> get $columns => [id, filePath, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_file_cleanup_table';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.PendingFileCleanupTableData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
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
  i1.PendingFileCleanupTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.PendingFileCleanupTableData(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PendingFileCleanupTableTable createAlias(String alias) {
    return $PendingFileCleanupTableTable(attachedDatabase, alias);
  }
}

class PendingFileCleanupTableData extends i0.DataClass
    implements i0.Insertable<i1.PendingFileCleanupTableData> {
  final int id;

  /// Silinmesi gereken fiziksel dosyanın tam yolu.
  final String filePath;

  /// Cleanup işinin ne zaman oluşturulduğunu takip eder.
  final DateTime createdAt;
  const PendingFileCleanupTableData({
    required this.id,
    required this.filePath,
    required this.createdAt,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['file_path'] = i0.Variable<String>(filePath);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    return map;
  }

  i1.PendingFileCleanupTableCompanion toCompanion(bool nullToAbsent) {
    return i1.PendingFileCleanupTableCompanion(
      id: i0.Value(id),
      filePath: i0.Value(filePath),
      createdAt: i0.Value(createdAt),
    );
  }

  factory PendingFileCleanupTableData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return PendingFileCleanupTableData(
      id: serializer.fromJson<int>(json['id']),
      filePath: serializer.fromJson<String>(json['filePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'filePath': serializer.toJson<String>(filePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  i1.PendingFileCleanupTableData copyWith({
    int? id,
    String? filePath,
    DateTime? createdAt,
  }) => i1.PendingFileCleanupTableData(
    id: id ?? this.id,
    filePath: filePath ?? this.filePath,
    createdAt: createdAt ?? this.createdAt,
  );
  PendingFileCleanupTableData copyWithCompanion(
    i1.PendingFileCleanupTableCompanion data,
  ) {
    return PendingFileCleanupTableData(
      id: data.id.present ? data.id.value : this.id,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingFileCleanupTableData(')
          ..write('id: $id, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, filePath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.PendingFileCleanupTableData &&
          other.id == this.id &&
          other.filePath == this.filePath &&
          other.createdAt == this.createdAt);
}

class PendingFileCleanupTableCompanion
    extends i0.UpdateCompanion<i1.PendingFileCleanupTableData> {
  final i0.Value<int> id;
  final i0.Value<String> filePath;
  final i0.Value<DateTime> createdAt;
  const PendingFileCleanupTableCompanion({
    this.id = const i0.Value.absent(),
    this.filePath = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
  });
  PendingFileCleanupTableCompanion.insert({
    this.id = const i0.Value.absent(),
    required String filePath,
    this.createdAt = const i0.Value.absent(),
  }) : filePath = i0.Value(filePath);
  static i0.Insertable<i1.PendingFileCleanupTableData> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? filePath,
    i0.Expression<DateTime>? createdAt,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (filePath != null) 'file_path': filePath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  i1.PendingFileCleanupTableCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<String>? filePath,
    i0.Value<DateTime>? createdAt,
  }) {
    return i1.PendingFileCleanupTableCompanion(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (filePath.present) {
      map['file_path'] = i0.Variable<String>(filePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingFileCleanupTableCompanion(')
          ..write('id: $id, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}
