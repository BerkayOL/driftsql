import 'package:drift/drift.dart';

import '../../buildings/data/buildings_table.dart';

/// Binalara ait katları tutan tablo.
///
/// İlişki:
///
/// Building 1 ------ N Floor
///
/// Yani:
/// - Bir binanın birden fazla katı olabilir.
/// - Her kat yalnızca bir binaya aittir.
class FloorsTable extends Table {
  /// Her katın benzersiz ID'si.
  IntColumn get id => integer().autoIncrement()();

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
  IntColumn get buildingId => integer().references(
    BuildingsTable,
    #id,

    /// Bir bina silinirse o binaya ait katlar da silinsin.
    ///
    /// Örneğin:
    ///
    /// Berlin House silindi
    ///       ↓
    /// Ground Floor
    /// First Floor
    /// Basement
    ///
    /// kayıtları da otomatik silinir.
    onDelete: KeyAction.cascade,
  )();

  /// Katın adı.
  ///
  /// Örnek:
  /// Basement
  /// Ground Floor
  /// First Floor
  TextColumn get name => text()();

  /// Kat numarası.
  ///
  /// Örneğin:
  /// Bodrum = -1
  /// Zemin = 0
  /// 1. Kat = 1
  /// 2. Kat = 2
  IntColumn get floorNumber => integer()();

  /// Kaydın oluşturulma zamanı.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
