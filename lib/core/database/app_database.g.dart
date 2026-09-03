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

class $BuildingsTableTable extends BuildingsTable
    with TableInfo<$BuildingsTableTable, BuildingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuildingsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryCodeMeta = const VerificationMeta(
    'countryCode',
  );
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
    'country_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 2,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _constructionYearMeta = const VerificationMeta(
    'constructionYear',
  );
  @override
  late final GeneratedColumn<int> constructionYear = GeneratedColumn<int>(
    'construction_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  List<GeneratedColumn> get $columns => [
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
  VerificationContext validateIntegrity(
    Insertable<BuildingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BuildingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BuildingsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      countryCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_code'],
      )!,
      constructionYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}construction_year'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BuildingsTableTable createAlias(String alias) {
    return $BuildingsTableTable(attachedDatabase, alias);
  }
}

class BuildingsTableData extends DataClass
    implements Insertable<BuildingsTableData> {
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['country_code'] = Variable<String>(countryCode);
    map['construction_year'] = Variable<int>(constructionYear);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BuildingsTableCompanion toCompanion(bool nullToAbsent) {
    return BuildingsTableCompanion(
      id: Value(id),
      name: Value(name),
      countryCode: Value(countryCode),
      constructionYear: Value(constructionYear),
      createdAt: Value(createdAt),
    );
  }

  factory BuildingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BuildingsTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      countryCode: serializer.fromJson<String>(json['countryCode']),
      constructionYear: serializer.fromJson<int>(json['constructionYear']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'countryCode': serializer.toJson<String>(countryCode),
      'constructionYear': serializer.toJson<int>(constructionYear),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BuildingsTableData copyWith({
    int? id,
    String? name,
    String? countryCode,
    int? constructionYear,
    DateTime? createdAt,
  }) => BuildingsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    countryCode: countryCode ?? this.countryCode,
    constructionYear: constructionYear ?? this.constructionYear,
    createdAt: createdAt ?? this.createdAt,
  );
  BuildingsTableData copyWithCompanion(BuildingsTableCompanion data) {
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
      (other is BuildingsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.countryCode == this.countryCode &&
          other.constructionYear == this.constructionYear &&
          other.createdAt == this.createdAt);
}

class BuildingsTableCompanion extends UpdateCompanion<BuildingsTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> countryCode;
  final Value<int> constructionYear;
  final Value<DateTime> createdAt;
  const BuildingsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.constructionYear = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BuildingsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String countryCode,
    required int constructionYear,
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       countryCode = Value(countryCode),
       constructionYear = Value(constructionYear);
  static Insertable<BuildingsTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? countryCode,
    Expression<int>? constructionYear,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (countryCode != null) 'country_code': countryCode,
      if (constructionYear != null) 'construction_year': constructionYear,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BuildingsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? countryCode,
    Value<int>? constructionYear,
    Value<DateTime>? createdAt,
  }) {
    return BuildingsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      constructionYear: constructionYear ?? this.constructionYear,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (constructionYear.present) {
      map['construction_year'] = Variable<int>(constructionYear.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OfflinePhotosTableTable offlinePhotosTable =
      $OfflinePhotosTableTable(this);
  late final $BuildingsTableTable buildingsTable = $BuildingsTableTable(this);
  late final PhotoDao photoDao = PhotoDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    offlinePhotosTable,
    buildingsTable,
  ];
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
typedef $$BuildingsTableTableCreateCompanionBuilder =
    BuildingsTableCompanion Function({
      Value<int> id,
      required String name,
      required String countryCode,
      required int constructionYear,
      Value<DateTime> createdAt,
    });
typedef $$BuildingsTableTableUpdateCompanionBuilder =
    BuildingsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> countryCode,
      Value<int> constructionYear,
      Value<DateTime> createdAt,
    });

class $$BuildingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $BuildingsTableTable> {
  $$BuildingsTableTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get constructionYear => $composableBuilder(
    column: $table.constructionYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BuildingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BuildingsTableTable> {
  $$BuildingsTableTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get constructionYear => $composableBuilder(
    column: $table.constructionYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BuildingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BuildingsTableTable> {
  $$BuildingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get constructionYear => $composableBuilder(
    column: $table.constructionYear,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BuildingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BuildingsTableTable,
          BuildingsTableData,
          $$BuildingsTableTableFilterComposer,
          $$BuildingsTableTableOrderingComposer,
          $$BuildingsTableTableAnnotationComposer,
          $$BuildingsTableTableCreateCompanionBuilder,
          $$BuildingsTableTableUpdateCompanionBuilder,
          (
            BuildingsTableData,
            BaseReferences<
              _$AppDatabase,
              $BuildingsTableTable,
              BuildingsTableData
            >,
          ),
          BuildingsTableData,
          PrefetchHooks Function()
        > {
  $$BuildingsTableTableTableManager(
    _$AppDatabase db,
    $BuildingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BuildingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BuildingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BuildingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> countryCode = const Value.absent(),
                Value<int> constructionYear = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BuildingsTableCompanion(
                id: id,
                name: name,
                countryCode: countryCode,
                constructionYear: constructionYear,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String countryCode,
                required int constructionYear,
                Value<DateTime> createdAt = const Value.absent(),
              }) => BuildingsTableCompanion.insert(
                id: id,
                name: name,
                countryCode: countryCode,
                constructionYear: constructionYear,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BuildingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BuildingsTableTable,
      BuildingsTableData,
      $$BuildingsTableTableFilterComposer,
      $$BuildingsTableTableOrderingComposer,
      $$BuildingsTableTableAnnotationComposer,
      $$BuildingsTableTableCreateCompanionBuilder,
      $$BuildingsTableTableUpdateCompanionBuilder,
      (
        BuildingsTableData,
        BaseReferences<_$AppDatabase, $BuildingsTableTable, BuildingsTableData>,
      ),
      BuildingsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OfflinePhotosTableTableTableManager get offlinePhotosTable =>
      $$OfflinePhotosTableTableTableManager(_db, _db.offlinePhotosTable);
  $$BuildingsTableTableTableManager get buildingsTable =>
      $$BuildingsTableTableTableManager(_db, _db.buildingsTable);
}
