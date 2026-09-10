import 'package:drift/drift.dart';

/// Database kaydı silinmiş fakat fiziksel dosyası henüz
/// temizlenmemiş fotoğrafları kalıcı olarak takip eder.
///
/// Uygulama kapanıp tekrar açılsa bile cleanup işi kaybolmaz.
class PendingFileCleanupTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Silinmesi gereken fiziksel dosyanın tam yolu.
  TextColumn get filePath => text().unique()();

  /// Cleanup işinin ne zaman oluşturulduğunu takip eder.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
