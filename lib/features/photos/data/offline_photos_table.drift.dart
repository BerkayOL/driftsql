// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:driftsql/features/photos/data/offline_photos_table.drift.dart'
    as i1;
import 'package:driftsql/features/photos/data/offline_photos_table.dart' as i2;
import 'package:drift/src/runtime/query_builder/query_builder.dart' as i3;
import 'package:driftsql/features/rooms/data/rooms_table.drift.dart' as i4;
import 'package:drift/internal/modular.dart' as i5;

typedef $$OfflinePhotosTableTableCreateCompanionBuilder =
    i1.OfflinePhotosTableCompanion Function({
      i0.Value<int> id,
      required String imagePath,
      i0.Value<int?> roomId,
      i0.Value<DateTime> createdAt,
    });
typedef $$OfflinePhotosTableTableUpdateCompanionBuilder =
    i1.OfflinePhotosTableCompanion Function({
      i0.Value<int> id,
      i0.Value<String> imagePath,
      i0.Value<int?> roomId,
      i0.Value<DateTime> createdAt,
    });

final class $$OfflinePhotosTableTableReferences
    extends
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.$OfflinePhotosTableTable,
          i1.OfflinePhotosTableData
        > {
  $$OfflinePhotosTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static i4.$RoomsTableTable _roomIdTable(i0.GeneratedDatabase db) =>
      i5.ReadDatabaseContainer(db)
          .resultSet<i4.$RoomsTableTable>('rooms_table')
          .createAlias('offline_photos_table__room_id__rooms_table__id');

  i4.$$RoomsTableTableProcessedTableManager? get roomId {
    final $_column = $_itemColumn<int>('room_id');
    if ($_column == null) return null;
    final manager = i4
        .$$RoomsTableTableTableManager(
          $_db,
          i5.ReadDatabaseContainer(
            $_db,
          ).resultSet<i4.$RoomsTableTable>('rooms_table'),
        )
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roomIdTable($_db));
    if (item == null) return manager;
    return i0.ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OfflinePhotosTableTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$OfflinePhotosTableTable> {
  $$OfflinePhotosTableTableFilterComposer({
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

  i0.ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i4.$$RoomsTableTableFilterComposer get roomId {
    final i4.$$RoomsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: i5.ReadDatabaseContainer(
        $db,
      ).resultSet<i4.$RoomsTableTable>('rooms_table'),
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => i4.$$RoomsTableTableFilterComposer(
            $db: $db,
            $table: i5.ReadDatabaseContainer(
              $db,
            ).resultSet<i4.$RoomsTableTable>('rooms_table'),
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
    extends i0.Composer<i0.GeneratedDatabase, i1.$OfflinePhotosTableTable> {
  $$OfflinePhotosTableTableOrderingComposer({
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

  i0.ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i4.$$RoomsTableTableOrderingComposer get roomId {
    final i4.$$RoomsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: i5.ReadDatabaseContainer(
        $db,
      ).resultSet<i4.$RoomsTableTable>('rooms_table'),
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => i4.$$RoomsTableTableOrderingComposer(
            $db: $db,
            $table: i5.ReadDatabaseContainer(
              $db,
            ).resultSet<i4.$RoomsTableTable>('rooms_table'),
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
    extends i0.Composer<i0.GeneratedDatabase, i1.$OfflinePhotosTableTable> {
  $$OfflinePhotosTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  i4.$$RoomsTableTableAnnotationComposer get roomId {
    final i4.$$RoomsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: i5.ReadDatabaseContainer(
        $db,
      ).resultSet<i4.$RoomsTableTable>('rooms_table'),
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => i4.$$RoomsTableTableAnnotationComposer(
            $db: $db,
            $table: i5.ReadDatabaseContainer(
              $db,
            ).resultSet<i4.$RoomsTableTable>('rooms_table'),
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
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.$OfflinePhotosTableTable,
          i1.OfflinePhotosTableData,
          i1.$$OfflinePhotosTableTableFilterComposer,
          i1.$$OfflinePhotosTableTableOrderingComposer,
          i1.$$OfflinePhotosTableTableAnnotationComposer,
          $$OfflinePhotosTableTableCreateCompanionBuilder,
          $$OfflinePhotosTableTableUpdateCompanionBuilder,
          (i1.OfflinePhotosTableData, i1.$$OfflinePhotosTableTableReferences),
          i1.OfflinePhotosTableData,
          i0.PrefetchHooks Function({bool roomId})
        > {
  $$OfflinePhotosTableTableTableManager(
    i0.GeneratedDatabase db,
    i1.$OfflinePhotosTableTable table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => i1
              .$$OfflinePhotosTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$OfflinePhotosTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              i1.$$OfflinePhotosTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<String> imagePath = const i0.Value.absent(),
                i0.Value<int?> roomId = const i0.Value.absent(),
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
              }) => i1.OfflinePhotosTableCompanion(
                id: id,
                imagePath: imagePath,
                roomId: roomId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required String imagePath,
                i0.Value<int?> roomId = const i0.Value.absent(),
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
              }) => i1.OfflinePhotosTableCompanion.insert(
                id: id,
                imagePath: imagePath,
                roomId: roomId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  i1.$$OfflinePhotosTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({roomId = false}) {
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
                    if (roomId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.roomId,
                                referencedTable: i1
                                    .$$OfflinePhotosTableTableReferences
                                    ._roomIdTable(db),
                                referencedColumn: i1
                                    .$$OfflinePhotosTableTableReferences
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
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.$OfflinePhotosTableTable,
      i1.OfflinePhotosTableData,
      i1.$$OfflinePhotosTableTableFilterComposer,
      i1.$$OfflinePhotosTableTableOrderingComposer,
      i1.$$OfflinePhotosTableTableAnnotationComposer,
      $$OfflinePhotosTableTableCreateCompanionBuilder,
      $$OfflinePhotosTableTableUpdateCompanionBuilder,
      (i1.OfflinePhotosTableData, i1.$$OfflinePhotosTableTableReferences),
      i1.OfflinePhotosTableData,
      i0.PrefetchHooks Function({bool roomId})
    >;
i0.Index get idxOfflinePhotosRoomCreatedAt => i0.Index(
  'idx_offline_photos_room_created_at',
  'CREATE INDEX idx_offline_photos_room_created_at ON offline_photos_table (room_id, created_at)',
);

class $OfflinePhotosTableTable extends i2.OfflinePhotosTable
    with i0.TableInfo<$OfflinePhotosTableTable, i1.OfflinePhotosTableData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OfflinePhotosTableTable(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _imagePathMeta = const i0.VerificationMeta(
    'imagePath',
  );
  @override
  late final i0.GeneratedColumn<String> imagePath = i0.GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _roomIdMeta = const i0.VerificationMeta(
    'roomId',
  );
  @override
  late final i0.GeneratedColumn<int> roomId = i0.GeneratedColumn<int>(
    'room_id',
    aliasedName,
    true,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'REFERENCES rooms_table (id) ON DELETE SET NULL',
    ),
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
  List<i0.GeneratedColumn> get $columns => [id, imagePath, roomId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'offline_photos_table';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.OfflinePhotosTableData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
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
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.OfflinePhotosTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.OfflinePhotosTableData(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      roomId: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}room_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $OfflinePhotosTableTable createAlias(String alias) {
    return $OfflinePhotosTableTable(attachedDatabase, alias);
  }
}

class OfflinePhotosTableData extends i0.DataClass
    implements i0.Insertable<i1.OfflinePhotosTableData> {
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
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['image_path'] = i0.Variable<String>(imagePath);
    if (!nullToAbsent || roomId != null) {
      map['room_id'] = i0.Variable<int>(roomId);
    }
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    return map;
  }

  i1.OfflinePhotosTableCompanion toCompanion(bool nullToAbsent) {
    return i1.OfflinePhotosTableCompanion(
      id: i0.Value(id),
      imagePath: i0.Value(imagePath),
      roomId: roomId == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(roomId),
      createdAt: i0.Value(createdAt),
    );
  }

  factory OfflinePhotosTableData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return OfflinePhotosTableData(
      id: serializer.fromJson<int>(json['id']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      roomId: serializer.fromJson<int?>(json['roomId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imagePath': serializer.toJson<String>(imagePath),
      'roomId': serializer.toJson<int?>(roomId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  i1.OfflinePhotosTableData copyWith({
    int? id,
    String? imagePath,
    i0.Value<int?> roomId = const i0.Value.absent(),
    DateTime? createdAt,
  }) => i1.OfflinePhotosTableData(
    id: id ?? this.id,
    imagePath: imagePath ?? this.imagePath,
    roomId: roomId.present ? roomId.value : this.roomId,
    createdAt: createdAt ?? this.createdAt,
  );
  OfflinePhotosTableData copyWithCompanion(
    i1.OfflinePhotosTableCompanion data,
  ) {
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
      (other is i1.OfflinePhotosTableData &&
          other.id == this.id &&
          other.imagePath == this.imagePath &&
          other.roomId == this.roomId &&
          other.createdAt == this.createdAt);
}

class OfflinePhotosTableCompanion
    extends i0.UpdateCompanion<i1.OfflinePhotosTableData> {
  final i0.Value<int> id;
  final i0.Value<String> imagePath;
  final i0.Value<int?> roomId;
  final i0.Value<DateTime> createdAt;
  const OfflinePhotosTableCompanion({
    this.id = const i0.Value.absent(),
    this.imagePath = const i0.Value.absent(),
    this.roomId = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
  });
  OfflinePhotosTableCompanion.insert({
    this.id = const i0.Value.absent(),
    required String imagePath,
    this.roomId = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
  }) : imagePath = i0.Value(imagePath);
  static i0.Insertable<i1.OfflinePhotosTableData> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? imagePath,
    i0.Expression<int>? roomId,
    i0.Expression<DateTime>? createdAt,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (imagePath != null) 'image_path': imagePath,
      if (roomId != null) 'room_id': roomId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  i1.OfflinePhotosTableCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<String>? imagePath,
    i0.Value<int?>? roomId,
    i0.Value<DateTime>? createdAt,
  }) {
    return i1.OfflinePhotosTableCompanion(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      roomId: roomId ?? this.roomId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (imagePath.present) {
      map['image_path'] = i0.Variable<String>(imagePath.value);
    }
    if (roomId.present) {
      map['room_id'] = i0.Variable<int>(roomId.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
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
