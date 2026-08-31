import 'package:drift/drift.dart';

class OfflinePhotosTable extends Table {
  // 1. Benzersiz Kimlik (Primary Key)
  // Her Fotoğraf kaydının eşsiz bir Id'si olmalıdır. Otomatik artan (autoIncrement) yapıyoruz.
  IntColumn get id => integer().autoIncrement()();

  // 2. Dosya Yolu
  // Fotoğrafın kendisini değil, cihazdaki "kalıcı adresini" metin (string) olarak saklıyoruz.
  TextColumn get imagePath => text()();

  // 3. Oluşturulma Tarihi (createdAt)
  // Hangi fotoğrafın ne zaman çekildiğini/eklendiğini bilmek sıralama için çok işimize yarayabilir.
  // Bu yüzden tarih bilgisini saklıyoruz.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
