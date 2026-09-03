import 'package:drift/drift.dart';

/// Uygulamadaki binaların temel bilgilerini tutan tablo.
///
/// Gerçek ThermoPlanX projesinde bir bina;
/// katlar, odalar, ölçümler ve diğer birçok veriyle
/// ilişkili olacak.
///
/// Şimdilik ilişkisel yapıyı öğrenmek için
/// yalnızca temel bina bilgilerini tutuyoruz.
class BuildingsTable extends Table {
  /// Her bina için benzersiz primary key.
  ///
  /// SQLite bu değeri otomatik olarak artırır.
  IntColumn get id => integer().autoIncrement()();

  /// Kullanıcının binaya verdiği isim.
  ///
  /// Örnek:
  /// "Berlin Test Binası"
  TextColumn get name => text()();

  /// Binanın bulunduğu ülkenin kodu.
  ///
  /// Örnek:
  /// DE = Almanya
  /// AT = Avusturya
  ///
  /// Tam ülke adını saklamak yerine kod kullanmak,
  /// ileride filtreleme ve standardizasyon açısından daha sağlıklıdır.
  TextColumn get countryCode => text().withLength(
        min: 2,
        max: 2,
      )();

  /// Binanın yapım yılı.
  ///
  /// Örnek:
  /// 1985
  IntColumn get constructionYear => integer()();

  /// Kaydın local database'e ne zaman eklendiği.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}