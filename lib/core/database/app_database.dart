import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../features/photos/data/offline_photos_table.dart';

// Drift'in üreteceği (generate) dosyanın adını belirttik.
part 'app_database.g.dart';

@DriftDatabase(tables: [OfflinePhotosTable])
class AppDatabase extends _$AppDatabase {
  // Veritabanı dosyasının adını belirledik.
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // Veritabanı dosyasının cihazda saklanacağı dizini belirliyoruz.
  return LazyDatabase(() async {
    // Cihazın 'uygulamaya özel kalıcı klasörünü' buluyoruz.
    final dbFolder = await getApplicationDocumentsDirectory();

    // Veri tabanı dosyamızın adı ''app_database.sqlite'' olacak ve o klasörün içerisinde saklanacak.
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));

    // Bağlantıyı başlatma.
    return NativeDatabase.createInBackground(file);
  });
}
