import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:driftsql/features/photos/data/dao/photo_dao.dart';

import '../../features/photos/data/offline_photos_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    OfflinePhotosTable,
  ],
  daos: [
    PhotoDao,
  ],
)
final class AppDatabase extends _$AppDatabase {
  /// Normal uygulama çalışırken kullanılacak constructor.
  ///
  /// driftDatabase:
  /// - Platforma uygun SQLite bağlantısını oluşturur.
  /// - Native platformlarda database dosyasını uygulamanın
  ///   kalıcı klasöründe saklar.
  /// - Veritabanı dosyamız: app_database.sqlite
  AppDatabase.defaults()
      : super(
          driftDatabase(
            name: 'app_database',
          ),
        );

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
  int get schemaVersion => 1;
}