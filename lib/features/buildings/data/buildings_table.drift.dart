// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:driftsql/features/buildings/data/buildings_table.drift.dart'
    as i1;
import 'package:driftsql/features/buildings/data/buildings_table.dart' as i2;
import 'package:drift/src/runtime/query_builder/query_builder.dart' as i3;

typedef $$BuildingsTableTableCreateCompanionBuilder =
    i1.BuildingsTableCompanion Function({
      i0.Value<int> id,
      required String name,
      required String countryCode,
      required int constructionYear,
      i0.Value<DateTime> createdAt,
    });
typedef $$BuildingsTableTableUpdateCompanionBuilder =
    i1.BuildingsTableCompanion Function({
      i0.Value<int> id,
      i0.Value<String> name,
      i0.Value<String> countryCode,
      i0.Value<int> constructionYear,
      i0.Value<DateTime> createdAt,
    });

class $$BuildingsTableTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$BuildingsTableTable> {
  $$BuildingsTableTableFilterComposer({
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

  i0.ColumnFilters<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get constructionYear => $composableBuilder(
    column: $table.constructionYear,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $$BuildingsTableTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$BuildingsTableTable> {
  $$BuildingsTableTableOrderingComposer({
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

  i0.ColumnOrderings<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get constructionYear => $composableBuilder(
    column: $table.constructionYear,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $$BuildingsTableTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$BuildingsTableTable> {
  $$BuildingsTableTableAnnotationComposer({
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

  i0.GeneratedColumn<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get constructionYear => $composableBuilder(
    column: $table.constructionYear,
    builder: (column) => column,
  );

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BuildingsTableTableTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.$BuildingsTableTable,
          i1.BuildingsTableData,
          i1.$$BuildingsTableTableFilterComposer,
          i1.$$BuildingsTableTableOrderingComposer,
          i1.$$BuildingsTableTableAnnotationComposer,
          $$BuildingsTableTableCreateCompanionBuilder,
          $$BuildingsTableTableUpdateCompanionBuilder,
          (
            i1.BuildingsTableData,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.$BuildingsTableTable,
              i1.BuildingsTableData
            >,
          ),
          i1.BuildingsTableData,
          i0.PrefetchHooks Function()
        > {
  $$BuildingsTableTableTableManager(
    i0.GeneratedDatabase db,
    i1.$BuildingsTableTable table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$BuildingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$BuildingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => i1
              .$$BuildingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<String> name = const i0.Value.absent(),
                i0.Value<String> countryCode = const i0.Value.absent(),
                i0.Value<int> constructionYear = const i0.Value.absent(),
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
              }) => i1.BuildingsTableCompanion(
                id: id,
                name: name,
                countryCode: countryCode,
                constructionYear: constructionYear,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required String name,
                required String countryCode,
                required int constructionYear,
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
              }) => i1.BuildingsTableCompanion.insert(
                id: id,
                name: name,
                countryCode: countryCode,
                constructionYear: constructionYear,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BuildingsTableTableProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.$BuildingsTableTable,
      i1.BuildingsTableData,
      i1.$$BuildingsTableTableFilterComposer,
      i1.$$BuildingsTableTableOrderingComposer,
      i1.$$BuildingsTableTableAnnotationComposer,
      $$BuildingsTableTableCreateCompanionBuilder,
      $$BuildingsTableTableUpdateCompanionBuilder,
      (
        i1.BuildingsTableData,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.$BuildingsTableTable,
          i1.BuildingsTableData
        >,
      ),
      i1.BuildingsTableData,
      i0.PrefetchHooks Function()
    >;

class $BuildingsTableTable extends i2.BuildingsTable
    with i0.TableInfo<$BuildingsTableTable, i1.BuildingsTableData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuildingsTableTable(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _countryCodeMeta = const i0.VerificationMeta(
    'countryCode',
  );
  @override
  late final i0.GeneratedColumn<String> countryCode =
      i0.GeneratedColumn<String>(
        'country_code',
        aliasedName,
        false,
        additionalChecks: i0.GeneratedColumn.checkTextLength(
          minTextLength: 2,
          maxTextLength: 2,
        ),
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const i0.VerificationMeta _constructionYearMeta =
      const i0.VerificationMeta('constructionYear');
  @override
  late final i0.GeneratedColumn<int> constructionYear = i0.GeneratedColumn<int>(
    'construction_year',
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
    name,
    countryCode,
    constructionYear,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'buildings_table';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.BuildingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('country_code')) {
      context.handle(
        _countryCodeMeta,
        countryCode.isAcceptableOrUnknown(
          data['country_code']!,
          _countryCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_countryCodeMeta);
    }
    if (data.containsKey('construction_year')) {
      context.handle(
        _constructionYearMeta,
        constructionYear.isAcceptableOrUnknown(
          data['construction_year']!,
          _constructionYearMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_constructionYearMeta);
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
  i1.BuildingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.BuildingsTableData(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      countryCode: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}country_code'],
      )!,
      constructionYear: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}construction_year'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BuildingsTableTable createAlias(String alias) {
    return $BuildingsTableTable(attachedDatabase, alias);
  }
}

class BuildingsTableData extends i0.DataClass
    implements i0.Insertable<i1.BuildingsTableData> {
  /// Her bina için benzersiz primary key.
  ///
  /// SQLite bu değeri otomatik olarak artırır.
  final int id;

  /// Kullanıcının binaya verdiği isim.
  ///
  /// Örnek:
  /// "Berlin Test Binası"
  final String name;

  /// Binanın bulunduğu ülkenin kodu.
  ///
  /// Örnek:
  /// DE = Almanya
  /// AT = Avusturya
  ///
  /// Tam ülke adını saklamak yerine kod kullanmak,
  /// ileride filtreleme ve standardizasyon açısından daha sağlıklıdır.
  final String countryCode;

  /// Binanın yapım yılı.
  ///
  /// Örnek:
  /// 1985
  final int constructionYear;

  /// Kaydın local database'e ne zaman eklendiği.
  final DateTime createdAt;
  const BuildingsTableData({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.constructionYear,
    required this.createdAt,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['name'] = i0.Variable<String>(name);
    map['country_code'] = i0.Variable<String>(countryCode);
    map['construction_year'] = i0.Variable<int>(constructionYear);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    return map;
  }

  i1.BuildingsTableCompanion toCompanion(bool nullToAbsent) {
    return i1.BuildingsTableCompanion(
      id: i0.Value(id),
      name: i0.Value(name),
      countryCode: i0.Value(countryCode),
      constructionYear: i0.Value(constructionYear),
      createdAt: i0.Value(createdAt),
    );
  }

  factory BuildingsTableData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return BuildingsTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      countryCode: serializer.fromJson<String>(json['countryCode']),
      constructionYear: serializer.fromJson<int>(json['constructionYear']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'countryCode': serializer.toJson<String>(countryCode),
      'constructionYear': serializer.toJson<int>(constructionYear),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  i1.BuildingsTableData copyWith({
    int? id,
    String? name,
    String? countryCode,
    int? constructionYear,
    DateTime? createdAt,
  }) => i1.BuildingsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    countryCode: countryCode ?? this.countryCode,
    constructionYear: constructionYear ?? this.constructionYear,
    createdAt: createdAt ?? this.createdAt,
  );
  BuildingsTableData copyWithCompanion(i1.BuildingsTableCompanion data) {
    return BuildingsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      countryCode: data.countryCode.present
          ? data.countryCode.value
          : this.countryCode,
      constructionYear: data.constructionYear.present
          ? data.constructionYear.value
          : this.constructionYear,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BuildingsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('countryCode: $countryCode, ')
          ..write('constructionYear: $constructionYear, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, countryCode, constructionYear, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.BuildingsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.countryCode == this.countryCode &&
          other.constructionYear == this.constructionYear &&
          other.createdAt == this.createdAt);
}

class BuildingsTableCompanion
    extends i0.UpdateCompanion<i1.BuildingsTableData> {
  final i0.Value<int> id;
  final i0.Value<String> name;
  final i0.Value<String> countryCode;
  final i0.Value<int> constructionYear;
  final i0.Value<DateTime> createdAt;
  const BuildingsTableCompanion({
    this.id = const i0.Value.absent(),
    this.name = const i0.Value.absent(),
    this.countryCode = const i0.Value.absent(),
    this.constructionYear = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
  });
  BuildingsTableCompanion.insert({
    this.id = const i0.Value.absent(),
    required String name,
    required String countryCode,
    required int constructionYear,
    this.createdAt = const i0.Value.absent(),
  }) : name = i0.Value(name),
       countryCode = i0.Value(countryCode),
       constructionYear = i0.Value(constructionYear);
  static i0.Insertable<i1.BuildingsTableData> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? name,
    i0.Expression<String>? countryCode,
    i0.Expression<int>? constructionYear,
    i0.Expression<DateTime>? createdAt,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (countryCode != null) 'country_code': countryCode,
      if (constructionYear != null) 'construction_year': constructionYear,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  i1.BuildingsTableCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<String>? name,
    i0.Value<String>? countryCode,
    i0.Value<int>? constructionYear,
    i0.Value<DateTime>? createdAt,
  }) {
    return i1.BuildingsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      constructionYear: constructionYear ?? this.constructionYear,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = i0.Variable<String>(name.value);
    }
    if (countryCode.present) {
      map['country_code'] = i0.Variable<String>(countryCode.value);
    }
    if (constructionYear.present) {
      map['construction_year'] = i0.Variable<int>(constructionYear.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuildingsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('countryCode: $countryCode, ')
          ..write('constructionYear: $constructionYear, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}
