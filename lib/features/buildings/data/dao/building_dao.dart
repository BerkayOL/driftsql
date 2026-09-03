import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../buildings_table.dart';

part 'building_dao.g.dart';

/// Binalarla ilgili local database işlemlerini yöneten DAO.
///
/// Bu sınıf:
/// - Bina kayıtlarını okur
/// - Yeni bina ekler
/// - Bina siler
/// - Filtreleme sorgularını çalıştırır
///
/// Cubit veya UI doğrudan Drift sorgusu yazmaz.
@DriftAccessor(tables: [BuildingsTable])
class BuildingDao extends DatabaseAccessor<AppDatabase>
    with _$BuildingDaoMixin {
  /// Bu DAO'nun hangi AppDatabase üzerinde çalışacağını belirler.
  BuildingDao(super.attachedDatabase);

  /// Bütün binaları reactive olarak izler.
  ///
  /// Yeni bina eklenirse, silinirse veya güncellenirse
  /// Drift güncel listeyi otomatik olarak Stream'e gönderir.
  ///
  /// En yeni eklenen bina en üstte gelir.
  Stream<List<BuildingsTableData>> watchAllBuildings() {
    final query = select(buildingsTable)
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]);

    return query.watch();
  }

  /// ID'si verilen tek bir binayı getirir.
  ///
  /// Bina bulunamazsa null döner.
  ///
  /// SQL karşılığı kabaca:
  ///
  /// SELECT *
  /// FROM buildings_table
  /// WHERE id = ?
  /// LIMIT 1;
  Future<BuildingsTableData?> getBuildingById(int id) {
    return (select(
      buildingsTable,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  /// Yeni bina kaydı oluşturur.
  ///
  /// ID ve createdAt otomatik oluşturulduğu için
  /// dışarıdan göndermemize gerek yok.
  Future<int> insertBuilding({
    required String name,
    required String countryCode,
    required int constructionYear,
  }) {
    return into(buildingsTable).insert(
      BuildingsTableCompanion.insert(
        name: name,
        countryCode: countryCode,
        constructionYear: constructionYear,
      ),
    );
  }

  /// Belirtilen ID'ye sahip binayı siler.
  Future<int> deleteBuildingById(int id) {
    return (delete(buildingsTable)..where((table) => table.id.equals(id))).go();
  }

  /// Belirli bir ülkede bulunan ve verilen yıldan
  /// önce yapılmış binaları reactive olarak izler.
  ///
  /// Örnek:
  ///
  /// countryCode = 'DE'
  /// builtBefore = 1990
  ///
  /// Sonuç:
  /// Almanya'da 1990'dan önce yapılmış binalar.
  Stream<List<BuildingsTableData>> watchBuildingsByCountryAndYear({
    required String countryCode,
    required int builtBefore,
  }) {
    final query = select(buildingsTable)
      ..where(
        (table) =>
            table.countryCode.equals(countryCode) &
            table.constructionYear.isSmallerThanValue(builtBefore),
      )
      ..orderBy([(table) => OrderingTerm.asc(table.constructionYear)]);

    return query.watch();
  }
}
