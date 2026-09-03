import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:driftsql/features/buildings/data/dao/building_dao.dart';
import 'package:driftsql/features/photos/data/dao/photo_dao.dart';

import '../../features/photos/data/offline_photos_table.dart';
import '../../features/buildings/data/buildings_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [OfflinePhotosTable, BuildingsTable],
  daos: [PhotoDao, BuildingDao],
)
final class AppDatabase extends _$AppDatabase {
  /// Normal uygulama çalışırken kullanılacak constructor.
  ///
  /// driftDatabase:
  /// - Platforma uygun SQLite bağlantısını oluşturur.
  /// - Native platformlarda database dosyasını uygulamanın
  ///   kalıcı klasöründe saklar.
  /// - Veritabanı dosyamız: app_database.sqlite
  AppDatabase.defaults() : super(driftDatabase(name: 'app_database'));

  /// Testlerde farklı bir database bağlantısı verebilmemizi sağlar.
  ///
  /// Örneğin ileride gerçek dosya oluşturmadan memory database
  /// kullanarak unit test yazabiliriz.
  AppDatabase(super.e);

  /// Bu değer uygulama versiyonu değildir.
  ///
  /// Sadece database şemasının versiyonudur.
  /// Tablo/kolon yapısı değiştiğinde migration ile birlikte artırılır.
  @override
  int get schemaVersion => 2;

  /// Database şeması değiştiğinde eski kullanıcıların
  /// verilerini silmeden yeni şemaya geçmemizi sağlar.
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      /// Uygulama ilk kez kuruluyorsa database henüz yoktur.
      ///
      /// Bu durumda Drift mevcut bütün tabloları sıfırdan oluşturur.
      onCreate: (m) async {
        await m.createAll();
      },

      /// Cihazda daha eski bir database varsa çalışır.
      ///
      /// Örneğin:
      /// Version 1 -> Version 2
      onUpgrade: (Migrator m, int from, int to) async {
        /// Version 2'de BuildingsTable eklendi.
        ///
        /// Eğer kullanıcının database'i version 1 ise
        /// sadece yeni tabloyu oluşturuyoruz.
        if (from < 2) {
          await m.createTable(buildingsTable);
        }
      },
    );
  }
}
