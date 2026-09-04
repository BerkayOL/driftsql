// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
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

class $FloorsTableTable extends FloorsTable
    with TableInfo<$FloorsTableTable, FloorsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FloorsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _buildingIdMeta = const VerificationMeta(
    'buildingId',
  );
  @override
  late final GeneratedColumn<int> buildingId = GeneratedColumn<int>(
    'building_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES buildings_table (id) ON DELETE CASCADE',
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
  static const VerificationMeta _floorNumberMeta = const VerificationMeta(
    'floorNumber',
  );
  @override
  late final GeneratedColumn<int> floorNumber = GeneratedColumn<int>(
    'floor_number',
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
  VerificationContext validateIntegrity(
    Insertable<FloorsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FloorsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FloorsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      buildingId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}building_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      floorNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}floor_number'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FloorsTableTable createAlias(String alias) {
    return $FloorsTableTable(attachedDatabase, alias);
  }
}

class FloorsTableData extends DataClass implements Insertable<FloorsTableData> {
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['building_id'] = Variable<int>(buildingId);
    map['name'] = Variable<String>(name);
    map['floor_number'] = Variable<int>(floorNumber);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FloorsTableCompanion toCompanion(bool nullToAbsent) {
    return FloorsTableCompanion(
      id: Value(id),
      buildingId: Value(buildingId),
      name: Value(name),
      floorNumber: Value(floorNumber),
      createdAt: Value(createdAt),
    );
  }

  factory FloorsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FloorsTableData(
      id: serializer.fromJson<int>(json['id']),
      buildingId: serializer.fromJson<int>(json['buildingId']),
      name: serializer.fromJson<String>(json['name']),
      floorNumber: serializer.fromJson<int>(json['floorNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'buildingId': serializer.toJson<int>(buildingId),
      'name': serializer.toJson<String>(name),
      'floorNumber': serializer.toJson<int>(floorNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FloorsTableData copyWith({
    int? id,
    int? buildingId,
    String? name,
    int? floorNumber,
    DateTime? createdAt,
  }) => FloorsTableData(
    id: id ?? this.id,
    buildingId: buildingId ?? this.buildingId,
    name: name ?? this.name,
    floorNumber: floorNumber ?? this.floorNumber,
    createdAt: createdAt ?? this.createdAt,
  );
  FloorsTableData copyWithCompanion(FloorsTableCompanion data) {
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
      (other is FloorsTableData &&
          other.id == this.id &&
          other.buildingId == this.buildingId &&
          other.name == this.name &&
          other.floorNumber == this.floorNumber &&
          other.createdAt == this.createdAt);
}

class FloorsTableCompanion extends UpdateCompanion<FloorsTableData> {
  final Value<int> id;
  final Value<int> buildingId;
  final Value<String> name;
  final Value<int> floorNumber;
  final Value<DateTime> createdAt;
  const FloorsTableCompanion({
    this.id = const Value.absent(),
    this.buildingId = const Value.absent(),
    this.name = const Value.absent(),
    this.floorNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FloorsTableCompanion.insert({
    this.id = const Value.absent(),
    required int buildingId,
    required String name,
    required int floorNumber,
    this.createdAt = const Value.absent(),
  }) : buildingId = Value(buildingId),
       name = Value(name),
       floorNumber = Value(floorNumber);
  static Insertable<FloorsTableData> custom({
    Expression<int>? id,
    Expression<int>? buildingId,
    Expression<String>? name,
    Expression<int>? floorNumber,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buildingId != null) 'building_id': buildingId,
      if (name != null) 'name': name,
      if (floorNumber != null) 'floor_number': floorNumber,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FloorsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? buildingId,
    Value<String>? name,
    Value<int>? floorNumber,
    Value<DateTime>? createdAt,
  }) {
    return FloorsTableCompanion(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      name: name ?? this.name,
      floorNumber: floorNumber ?? this.floorNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (buildingId.present) {
      map['building_id'] = Variable<int>(buildingId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (floorNumber.present) {
      map['floor_number'] = Variable<int>(floorNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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

class $RoomsTableTable extends RoomsTable
    with TableInfo<$RoomsTableTable, RoomsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoomsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _floorIdMeta = const VerificationMeta(
    'floorId',
  );
  @override
  late final GeneratedColumn<int> floorId = GeneratedColumn<int>(
    'floor_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES floors_table (id) ON DELETE CASCADE',
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
  static const VerificationMeta _isHeatedMeta = const VerificationMeta(
    'isHeated',
  );
  @override
  late final GeneratedColumn<bool> isHeated = GeneratedColumn<bool>(
    'is_heated',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_heated" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _targetTemperatureMeta = const VerificationMeta(
    'targetTemperature',
  );
  @override
  late final GeneratedColumn<double> targetTemperature =
      GeneratedColumn<double>(
        'target_temperature',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<double> area = GeneratedColumn<double>(
    'area',
    aliasedName,
    false,
    type: DriftSqlType.double,
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
  VerificationContext validateIntegrity(
    Insertable<RoomsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoomsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoomsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      floorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}floor_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isHeated: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_heated'],
      )!,
      targetTemperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_temperature'],
      ),
      area: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}area'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RoomsTableTable createAlias(String alias) {
    return $RoomsTableTable(attachedDatabase, alias);
  }
}

class RoomsTableData extends DataClass implements Insertable<RoomsTableData> {
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['floor_id'] = Variable<int>(floorId);
    map['name'] = Variable<String>(name);
    map['is_heated'] = Variable<bool>(isHeated);
    if (!nullToAbsent || targetTemperature != null) {
      map['target_temperature'] = Variable<double>(targetTemperature);
    }
    map['area'] = Variable<double>(area);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RoomsTableCompanion toCompanion(bool nullToAbsent) {
    return RoomsTableCompanion(
      id: Value(id),
      floorId: Value(floorId),
      name: Value(name),
      isHeated: Value(isHeated),
      targetTemperature: targetTemperature == null && nullToAbsent
          ? const Value.absent()
          : Value(targetTemperature),
      area: Value(area),
      createdAt: Value(createdAt),
    );
  }

  factory RoomsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
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
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
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

  RoomsTableData copyWith({
    int? id,
    int? floorId,
    String? name,
    bool? isHeated,
    Value<double?> targetTemperature = const Value.absent(),
    double? area,
    DateTime? createdAt,
  }) => RoomsTableData(
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
  RoomsTableData copyWithCompanion(RoomsTableCompanion data) {
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
      (other is RoomsTableData &&
          other.id == this.id &&
          other.floorId == this.floorId &&
          other.name == this.name &&
          other.isHeated == this.isHeated &&
          other.targetTemperature == this.targetTemperature &&
          other.area == this.area &&
          other.createdAt == this.createdAt);
}

class RoomsTableCompanion extends UpdateCompanion<RoomsTableData> {
  final Value<int> id;
  final Value<int> floorId;
  final Value<String> name;
  final Value<bool> isHeated;
  final Value<double?> targetTemperature;
  final Value<double> area;
  final Value<DateTime> createdAt;
  const RoomsTableCompanion({
    this.id = const Value.absent(),
    this.floorId = const Value.absent(),
    this.name = const Value.absent(),
    this.isHeated = const Value.absent(),
    this.targetTemperature = const Value.absent(),
    this.area = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RoomsTableCompanion.insert({
    this.id = const Value.absent(),
    required int floorId,
    required String name,
    this.isHeated = const Value.absent(),
    this.targetTemperature = const Value.absent(),
    required double area,
    this.createdAt = const Value.absent(),
  }) : floorId = Value(floorId),
       name = Value(name),
       area = Value(area);
  static Insertable<RoomsTableData> custom({
    Expression<int>? id,
    Expression<int>? floorId,
    Expression<String>? name,
    Expression<bool>? isHeated,
    Expression<double>? targetTemperature,
    Expression<double>? area,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (floorId != null) 'floor_id': floorId,
      if (name != null) 'name': name,
      if (isHeated != null) 'is_heated': isHeated,
      if (targetTemperature != null) 'target_temperature': targetTemperature,
      if (area != null) 'area': area,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RoomsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? floorId,
    Value<String>? name,
    Value<bool>? isHeated,
    Value<double?>? targetTemperature,
    Value<double>? area,
    Value<DateTime>? createdAt,
  }) {
    return RoomsTableCompanion(
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (floorId.present) {
      map['floor_id'] = Variable<int>(floorId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isHeated.present) {
      map['is_heated'] = Variable<bool>(isHeated.value);
    }
    if (targetTemperature.present) {
      map['target_temperature'] = Variable<double>(targetTemperature.value);
    }
    if (area.present) {
      map['area'] = Variable<double>(area.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
  static const VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  @override
  late final GeneratedColumn<int> roomId = GeneratedColumn<int>(
    'room_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rooms_table (id) ON DELETE SET NULL',
    ),
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
  List<GeneratedColumn> get $columns => [id, imagePath, roomId, createdAt];
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
    if (data.containsKey('room_id')) {
      context.handle(
        _roomIdMeta,
        roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta),
      );
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
      roomId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}room_id'],
      ),
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

  /// Eski fotoğraflar atanmamış kalabilsin diye nullable foreign key.
  /// Oda silinirse dosya ve fotoğraf kaydı korunur, yalnızca ilişki kaldırılır.
  final int? roomId;
  final DateTime createdAt;
  const OfflinePhotosTableData({
    required this.id,
    required this.imagePath,
    this.roomId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['image_path'] = Variable<String>(imagePath);
    if (!nullToAbsent || roomId != null) {
      map['room_id'] = Variable<int>(roomId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OfflinePhotosTableCompanion toCompanion(bool nullToAbsent) {
    return OfflinePhotosTableCompanion(
      id: Value(id),
      imagePath: Value(imagePath),
      roomId: roomId == null && nullToAbsent
          ? const Value.absent()
          : Value(roomId),
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
      roomId: serializer.fromJson<int?>(json['roomId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imagePath': serializer.toJson<String>(imagePath),
      'roomId': serializer.toJson<int?>(roomId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OfflinePhotosTableData copyWith({
    int? id,
    String? imagePath,
    Value<int?> roomId = const Value.absent(),
    DateTime? createdAt,
  }) => OfflinePhotosTableData(
    id: id ?? this.id,
    imagePath: imagePath ?? this.imagePath,
    roomId: roomId.present ? roomId.value : this.roomId,
    createdAt: createdAt ?? this.createdAt,
  );
  OfflinePhotosTableData copyWithCompanion(OfflinePhotosTableCompanion data) {
    return OfflinePhotosTableData(
      id: data.id.present ? data.id.value : this.id,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      roomId: data.roomId.present ? data.roomId.value : this.roomId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OfflinePhotosTableData(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('roomId: $roomId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imagePath, roomId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OfflinePhotosTableData &&
          other.id == this.id &&
          other.imagePath == this.imagePath &&
          other.roomId == this.roomId &&
          other.createdAt == this.createdAt);
}

class OfflinePhotosTableCompanion
    extends UpdateCompanion<OfflinePhotosTableData> {
  final Value<int> id;
  final Value<String> imagePath;
  final Value<int?> roomId;
  final Value<DateTime> createdAt;
  const OfflinePhotosTableCompanion({
    this.id = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.roomId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  OfflinePhotosTableCompanion.insert({
    this.id = const Value.absent(),
    required String imagePath,
    this.roomId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : imagePath = Value(imagePath);
  static Insertable<OfflinePhotosTableData> custom({
    Expression<int>? id,
    Expression<String>? imagePath,
    Expression<int>? roomId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imagePath != null) 'image_path': imagePath,
      if (roomId != null) 'room_id': roomId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  OfflinePhotosTableCompanion copyWith({
    Value<int>? id,
    Value<String>? imagePath,
    Value<int?>? roomId,
    Value<DateTime>? createdAt,
  }) {
    return OfflinePhotosTableCompanion(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      roomId: roomId ?? this.roomId,
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
    if (roomId.present) {
      map['room_id'] = Variable<int>(roomId.value);
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
          ..write('roomId: $roomId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BuildingsTableTable buildingsTable = $BuildingsTableTable(this);
  late final $FloorsTableTable floorsTable = $FloorsTableTable(this);
  late final $RoomsTableTable roomsTable = $RoomsTableTable(this);
  late final $OfflinePhotosTableTable offlinePhotosTable =
      $OfflinePhotosTableTable(this);
  late final PhotoDao photoDao = PhotoDao(this as AppDatabase);
  late final BuildingDao buildingDao = BuildingDao(this as AppDatabase);
  late final FloorDao floorDao = FloorDao(this as AppDatabase);
  late final RoomDao roomDao = RoomDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    buildingsTable,
    floorsTable,
    roomsTable,
    offlinePhotosTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'buildings_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('floors_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'floors_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('rooms_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'rooms_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('offline_photos_table', kind: UpdateKind.update)],
    ),
  ]);
}

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

final class $$BuildingsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $BuildingsTableTable,
          BuildingsTableData
        > {
  $$BuildingsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$FloorsTableTable, List<FloorsTableData>>
  _floorsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.floorsTable,
    aliasName: 'buildings_table__id__floors_table__building_id',
  );

  $$FloorsTableTableProcessedTableManager get floorsTableRefs {
    final manager = $$FloorsTableTableTableManager(
      $_db,
      $_db.floorsTable,
    ).filter((f) => f.buildingId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_floorsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  Expression<bool> floorsTableRefs(
    Expression<bool> Function($$FloorsTableTableFilterComposer f) f,
  ) {
    final $$FloorsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.floorsTable,
      getReferencedColumn: (t) => t.buildingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FloorsTableTableFilterComposer(
            $db: $db,
            $table: $db.floorsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  Expression<T> floorsTableRefs<T extends Object>(
    Expression<T> Function($$FloorsTableTableAnnotationComposer a) f,
  ) {
    final $$FloorsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.floorsTable,
      getReferencedColumn: (t) => t.buildingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FloorsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.floorsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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
          (BuildingsTableData, $$BuildingsTableTableReferences),
          BuildingsTableData,
          PrefetchHooks Function({bool floorsTableRefs})
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
              .map(
                (e) => (
                  e.readTable(table),
                  $$BuildingsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({floorsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (floorsTableRefs) db.floorsTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (floorsTableRefs)
                    await $_getPrefetchedData<
                      BuildingsTableData,
                      $BuildingsTableTable,
                      FloorsTableData
                    >(
                      currentTable: table,
                      referencedTable: $$BuildingsTableTableReferences
                          ._floorsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BuildingsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).floorsTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.buildingId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
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
      (BuildingsTableData, $$BuildingsTableTableReferences),
      BuildingsTableData,
      PrefetchHooks Function({bool floorsTableRefs})
    >;
typedef $$FloorsTableTableCreateCompanionBuilder =
    FloorsTableCompanion Function({
      Value<int> id,
      required int buildingId,
      required String name,
      required int floorNumber,
      Value<DateTime> createdAt,
    });
typedef $$FloorsTableTableUpdateCompanionBuilder =
    FloorsTableCompanion Function({
      Value<int> id,
      Value<int> buildingId,
      Value<String> name,
      Value<int> floorNumber,
      Value<DateTime> createdAt,
    });

final class $$FloorsTableTableReferences
    extends BaseReferences<_$AppDatabase, $FloorsTableTable, FloorsTableData> {
  $$FloorsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BuildingsTableTable _buildingIdTable(_$AppDatabase db) => db
      .buildingsTable
      .createAlias('floors_table__building_id__buildings_table__id');

  $$BuildingsTableTableProcessedTableManager get buildingId {
    final $_column = $_itemColumn<int>('building_id')!;

    final manager = $$BuildingsTableTableTableManager(
      $_db,
      $_db.buildingsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_buildingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RoomsTableTable, List<RoomsTableData>>
  _roomsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.roomsTable,
    aliasName: 'floors_table__id__rooms_table__floor_id',
  );

  $$RoomsTableTableProcessedTableManager get roomsTableRefs {
    final manager = $$RoomsTableTableTableManager(
      $_db,
      $_db.roomsTable,
    ).filter((f) => f.floorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_roomsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FloorsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FloorsTableTable> {
  $$FloorsTableTableFilterComposer({
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

  ColumnFilters<int> get floorNumber => $composableBuilder(
    column: $table.floorNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BuildingsTableTableFilterComposer get buildingId {
    final $$BuildingsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.buildingId,
      referencedTable: $db.buildingsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildingsTableTableFilterComposer(
            $db: $db,
            $table: $db.buildingsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> roomsTableRefs(
    Expression<bool> Function($$RoomsTableTableFilterComposer f) f,
  ) {
    final $$RoomsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roomsTable,
      getReferencedColumn: (t) => t.floorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableTableFilterComposer(
            $db: $db,
            $table: $db.roomsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FloorsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FloorsTableTable> {
  $$FloorsTableTableOrderingComposer({
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

  ColumnOrderings<int> get floorNumber => $composableBuilder(
    column: $table.floorNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BuildingsTableTableOrderingComposer get buildingId {
    final $$BuildingsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.buildingId,
      referencedTable: $db.buildingsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildingsTableTableOrderingComposer(
            $db: $db,
            $table: $db.buildingsTable,
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
    extends Composer<_$AppDatabase, $FloorsTableTable> {
  $$FloorsTableTableAnnotationComposer({
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

  GeneratedColumn<int> get floorNumber => $composableBuilder(
    column: $table.floorNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BuildingsTableTableAnnotationComposer get buildingId {
    final $$BuildingsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.buildingId,
      referencedTable: $db.buildingsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BuildingsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.buildingsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> roomsTableRefs<T extends Object>(
    Expression<T> Function($$RoomsTableTableAnnotationComposer a) f,
  ) {
    final $$RoomsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roomsTable,
      getReferencedColumn: (t) => t.floorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.roomsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FloorsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FloorsTableTable,
          FloorsTableData,
          $$FloorsTableTableFilterComposer,
          $$FloorsTableTableOrderingComposer,
          $$FloorsTableTableAnnotationComposer,
          $$FloorsTableTableCreateCompanionBuilder,
          $$FloorsTableTableUpdateCompanionBuilder,
          (FloorsTableData, $$FloorsTableTableReferences),
          FloorsTableData,
          PrefetchHooks Function({bool buildingId, bool roomsTableRefs})
        > {
  $$FloorsTableTableTableManager(_$AppDatabase db, $FloorsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FloorsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FloorsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FloorsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> buildingId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> floorNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FloorsTableCompanion(
                id: id,
                buildingId: buildingId,
                name: name,
                floorNumber: floorNumber,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int buildingId,
                required String name,
                required int floorNumber,
                Value<DateTime> createdAt = const Value.absent(),
              }) => FloorsTableCompanion.insert(
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
                  $$FloorsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({buildingId = false, roomsTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (roomsTableRefs) db.roomsTable],
                  addJoins:
                      <
                        T extends TableManagerState<
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
                                    referencedTable:
                                        $$FloorsTableTableReferences
                                            ._buildingIdTable(db),
                                    referencedColumn:
                                        $$FloorsTableTableReferences
                                            ._buildingIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (roomsTableRefs)
                        await $_getPrefetchedData<
                          FloorsTableData,
                          $FloorsTableTable,
                          RoomsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$FloorsTableTableReferences
                              ._roomsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FloorsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).roomsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.floorId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FloorsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FloorsTableTable,
      FloorsTableData,
      $$FloorsTableTableFilterComposer,
      $$FloorsTableTableOrderingComposer,
      $$FloorsTableTableAnnotationComposer,
      $$FloorsTableTableCreateCompanionBuilder,
      $$FloorsTableTableUpdateCompanionBuilder,
      (FloorsTableData, $$FloorsTableTableReferences),
      FloorsTableData,
      PrefetchHooks Function({bool buildingId, bool roomsTableRefs})
    >;
typedef $$RoomsTableTableCreateCompanionBuilder =
    RoomsTableCompanion Function({
      Value<int> id,
      required int floorId,
      required String name,
      Value<bool> isHeated,
      Value<double?> targetTemperature,
      required double area,
      Value<DateTime> createdAt,
    });
typedef $$RoomsTableTableUpdateCompanionBuilder =
    RoomsTableCompanion Function({
      Value<int> id,
      Value<int> floorId,
      Value<String> name,
      Value<bool> isHeated,
      Value<double?> targetTemperature,
      Value<double> area,
      Value<DateTime> createdAt,
    });

final class $$RoomsTableTableReferences
    extends BaseReferences<_$AppDatabase, $RoomsTableTable, RoomsTableData> {
  $$RoomsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FloorsTableTable _floorIdTable(_$AppDatabase db) =>
      db.floorsTable.createAlias('rooms_table__floor_id__floors_table__id');

  $$FloorsTableTableProcessedTableManager get floorId {
    final $_column = $_itemColumn<int>('floor_id')!;

    final manager = $$FloorsTableTableTableManager(
      $_db,
      $_db.floorsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_floorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $OfflinePhotosTableTable,
    List<OfflinePhotosTableData>
  >
  _offlinePhotosTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.offlinePhotosTable,
        aliasName: 'rooms_table__id__offline_photos_table__room_id',
      );

  $$OfflinePhotosTableTableProcessedTableManager get offlinePhotosTableRefs {
    final manager = $$OfflinePhotosTableTableTableManager(
      $_db,
      $_db.offlinePhotosTable,
    ).filter((f) => f.roomId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _offlinePhotosTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoomsTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoomsTableTable> {
  $$RoomsTableTableFilterComposer({
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

  ColumnFilters<bool> get isHeated => $composableBuilder(
    column: $table.isHeated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetTemperature => $composableBuilder(
    column: $table.targetTemperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FloorsTableTableFilterComposer get floorId {
    final $$FloorsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.floorId,
      referencedTable: $db.floorsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FloorsTableTableFilterComposer(
            $db: $db,
            $table: $db.floorsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> offlinePhotosTableRefs(
    Expression<bool> Function($$OfflinePhotosTableTableFilterComposer f) f,
  ) {
    final $$OfflinePhotosTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.offlinePhotosTable,
      getReferencedColumn: (t) => t.roomId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OfflinePhotosTableTableFilterComposer(
            $db: $db,
            $table: $db.offlinePhotosTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoomsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoomsTableTable> {
  $$RoomsTableTableOrderingComposer({
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

  ColumnOrderings<bool> get isHeated => $composableBuilder(
    column: $table.isHeated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetTemperature => $composableBuilder(
    column: $table.targetTemperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FloorsTableTableOrderingComposer get floorId {
    final $$FloorsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.floorId,
      referencedTable: $db.floorsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FloorsTableTableOrderingComposer(
            $db: $db,
            $table: $db.floorsTable,
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
    extends Composer<_$AppDatabase, $RoomsTableTable> {
  $$RoomsTableTableAnnotationComposer({
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

  GeneratedColumn<bool> get isHeated =>
      $composableBuilder(column: $table.isHeated, builder: (column) => column);

  GeneratedColumn<double> get targetTemperature => $composableBuilder(
    column: $table.targetTemperature,
    builder: (column) => column,
  );

  GeneratedColumn<double> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$FloorsTableTableAnnotationComposer get floorId {
    final $$FloorsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.floorId,
      referencedTable: $db.floorsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FloorsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.floorsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> offlinePhotosTableRefs<T extends Object>(
    Expression<T> Function($$OfflinePhotosTableTableAnnotationComposer a) f,
  ) {
    final $$OfflinePhotosTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.offlinePhotosTable,
          getReferencedColumn: (t) => t.roomId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$OfflinePhotosTableTableAnnotationComposer(
                $db: $db,
                $table: $db.offlinePhotosTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RoomsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoomsTableTable,
          RoomsTableData,
          $$RoomsTableTableFilterComposer,
          $$RoomsTableTableOrderingComposer,
          $$RoomsTableTableAnnotationComposer,
          $$RoomsTableTableCreateCompanionBuilder,
          $$RoomsTableTableUpdateCompanionBuilder,
          (RoomsTableData, $$RoomsTableTableReferences),
          RoomsTableData,
          PrefetchHooks Function({bool floorId, bool offlinePhotosTableRefs})
        > {
  $$RoomsTableTableTableManager(_$AppDatabase db, $RoomsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoomsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoomsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoomsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> floorId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isHeated = const Value.absent(),
                Value<double?> targetTemperature = const Value.absent(),
                Value<double> area = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RoomsTableCompanion(
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
                Value<int> id = const Value.absent(),
                required int floorId,
                required String name,
                Value<bool> isHeated = const Value.absent(),
                Value<double?> targetTemperature = const Value.absent(),
                required double area,
                Value<DateTime> createdAt = const Value.absent(),
              }) => RoomsTableCompanion.insert(
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
                  $$RoomsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({floorId = false, offlinePhotosTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (offlinePhotosTableRefs) db.offlinePhotosTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
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
                                    referencedTable: $$RoomsTableTableReferences
                                        ._floorIdTable(db),
                                    referencedColumn:
                                        $$RoomsTableTableReferences
                                            ._floorIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (offlinePhotosTableRefs)
                        await $_getPrefetchedData<
                          RoomsTableData,
                          $RoomsTableTable,
                          OfflinePhotosTableData
                        >(
                          currentTable: table,
                          referencedTable: $$RoomsTableTableReferences
                              ._offlinePhotosTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoomsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).offlinePhotosTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.roomId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RoomsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoomsTableTable,
      RoomsTableData,
      $$RoomsTableTableFilterComposer,
      $$RoomsTableTableOrderingComposer,
      $$RoomsTableTableAnnotationComposer,
      $$RoomsTableTableCreateCompanionBuilder,
      $$RoomsTableTableUpdateCompanionBuilder,
      (RoomsTableData, $$RoomsTableTableReferences),
      RoomsTableData,
      PrefetchHooks Function({bool floorId, bool offlinePhotosTableRefs})
    >;
typedef $$OfflinePhotosTableTableCreateCompanionBuilder =
    OfflinePhotosTableCompanion Function({
      Value<int> id,
      required String imagePath,
      Value<int?> roomId,
      Value<DateTime> createdAt,
    });
typedef $$OfflinePhotosTableTableUpdateCompanionBuilder =
    OfflinePhotosTableCompanion Function({
      Value<int> id,
      Value<String> imagePath,
      Value<int?> roomId,
      Value<DateTime> createdAt,
    });

final class $$OfflinePhotosTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $OfflinePhotosTableTable,
          OfflinePhotosTableData
        > {
  $$OfflinePhotosTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RoomsTableTable _roomIdTable(_$AppDatabase db) => db.roomsTable
      .createAlias('offline_photos_table__room_id__rooms_table__id');

  $$RoomsTableTableProcessedTableManager? get roomId {
    final $_column = $_itemColumn<int>('room_id');
    if ($_column == null) return null;
    final manager = $$RoomsTableTableTableManager(
      $_db,
      $_db.roomsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

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

  $$RoomsTableTableFilterComposer get roomId {
    final $$RoomsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: $db.roomsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableTableFilterComposer(
            $db: $db,
            $table: $db.roomsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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

  $$RoomsTableTableOrderingComposer get roomId {
    final $$RoomsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: $db.roomsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableTableOrderingComposer(
            $db: $db,
            $table: $db.roomsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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

  $$RoomsTableTableAnnotationComposer get roomId {
    final $$RoomsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: $db.roomsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.roomsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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
          (OfflinePhotosTableData, $$OfflinePhotosTableTableReferences),
          OfflinePhotosTableData,
          PrefetchHooks Function({bool roomId})
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
                Value<int?> roomId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => OfflinePhotosTableCompanion(
                id: id,
                imagePath: imagePath,
                roomId: roomId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String imagePath,
                Value<int?> roomId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => OfflinePhotosTableCompanion.insert(
                id: id,
                imagePath: imagePath,
                roomId: roomId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OfflinePhotosTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({roomId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
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
                    if (roomId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.roomId,
                                referencedTable:
                                    $$OfflinePhotosTableTableReferences
                                        ._roomIdTable(db),
                                referencedColumn:
                                    $$OfflinePhotosTableTableReferences
                                        ._roomIdTable(db)
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
      (OfflinePhotosTableData, $$OfflinePhotosTableTableReferences),
      OfflinePhotosTableData,
      PrefetchHooks Function({bool roomId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BuildingsTableTableTableManager get buildingsTable =>
      $$BuildingsTableTableTableManager(_db, _db.buildingsTable);
  $$FloorsTableTableTableManager get floorsTable =>
      $$FloorsTableTableTableManager(_db, _db.floorsTable);
  $$RoomsTableTableTableManager get roomsTable =>
      $$RoomsTableTableTableManager(_db, _db.roomsTable);
  $$OfflinePhotosTableTableTableManager get offlinePhotosTable =>
      $$OfflinePhotosTableTableTableManager(_db, _db.offlinePhotosTable);
}
