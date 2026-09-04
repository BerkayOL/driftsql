import 'package:drift/drift.dart';

import '../../rooms/data/rooms_table.dart';

class OfflinePhotosTable extends Table {
  // 1. Benzersiz Kimlik (Primary Key)
  // Her Fotoğraf kaydının eşsiz bir Id'si olmalıdır. Otomatik artan (autoIncrement) yapıyoruz.
  IntColumn get id => integer().autoIncrement()();

  // 2. Dosya Yolu
  // Fotoğrafın kendisini değil, cihazdaki "kalıcı adresini" metin (string) olarak saklıyoruz.
  TextColumn get imagePath => text()();

  /// Eski fotoğraflar atanmamış kalabilsin diye nullable foreign key.
  /// Oda silinirse dosya ve fotoğraf kaydı korunur, yalnızca ilişki kaldırılır.
  IntColumn get roomId => integer().nullable().references(
    RoomsTable,
    #id,
    onDelete: KeyAction.setNull,
  )();

  // 3. Oluşturulma Tarihi (createdAt)
  // Hangi fotoğrafın ne zaman çekildiğini/eklendiğini bilmek sıralama için çok işimize yarayabilir.
  // Bu yüzden tarih bilgisini saklıyoruz.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
