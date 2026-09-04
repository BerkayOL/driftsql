import 'package:drift/drift.dart';

import '../../floors/data/floors_table.dart';

/// Binadaki odaları tutan tablo.
///
/// İlişki:
///
/// Floor 1 -------- N Room
///
/// Yani:
/// - Bir katta birden fazla oda olabilir.
/// - Her oda yalnızca bir kata aittir.
class RoomsTable extends Table {
  /// Odanın hangi kata ait olduğunu belirten Primary Key.
  IntColumn get id => integer().autoIncrement()();

  /// Odanın hangi kata ait olduğunu belirten Foreign Key.
  ///
  /// rooms_table.floor_id
  ///          ↓
  /// floors_table.id
  ///
  /// Böylece Room ile Floor arasında gerçek
  /// ilişkisel database bağlantısı kurulmuş olur.

  IntColumn get floorId => integer().references(
    FloorsTable,
    #id,
    // Kat silinirse o kata bağlı odalar da silinir.
    onDelete: KeyAction.cascade,
  )();

  /// Odanın adı.
  ///
  /// Örnek:
  /// Living Room
  /// Kitchen
  /// Bedroom
  TextColumn get name => text()();

  /// Odanın ısıtılan bir alan olup olmadığını belirtir.
  BoolColumn get isHeated => boolean().withDefault(const Constant(true))();

  
  /// Odanın hedef sıcaklığı.
  ///
  /// Örnek:
  /// Living Room = 20.0
  /// Bathroom = 24.0
  ///
  /// Isıtılmayan bir oda için null bırakılabileceği
  /// için nullable tanımlıyoruz.
  RealColumn get targetTemperature => real().nullable()();


  /// Odanın alanı, metrekare cinsinden.
  ///
  /// Örnek:
  /// 18.5 m² 
  RealColumn get area => real()();

  /// Kaydın local database'e ekleme zamanı.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
