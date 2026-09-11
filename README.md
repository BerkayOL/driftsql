# Offline Relational Storage PoC

> Tested with Flutter 3.44.8 (stable).  
> Newer stable Flutter versions may also work.

Bu proje, saha operasyonlarında internet bağlantısı olmadan ilişkisel verilerin ve yüksek boyutlu medya dosyalarının cihaz üzerinde güvenli, ölçeklenebilir ve tutarlı şekilde saklanmasını test etmek amacıyla geliştirilmiş bir Proof of Concept (PoC) çalışmasıdır.

PoC; bina, kat, oda ve fotoğraf ilişkileri üzerinden Drift / SQLite tabanlı yerel veri mimarisini, migration süreçlerini, dosya sistemi tutarlılığını ve büyük veri setlerinde ölçeklenebilir sorgulama yaklaşımlarını deneyimlemeyi amaçlamaktadır.

## Mimari ve Teknolojik Kararlar

### Depolama Stratejisi — File System vs. Blob

Yüksek boyutlu medya dosyalarının doğrudan SQLite içerisinde Blob olarak tutulması yerine, fotoğraflar uygulamanın yerel dosya sistemine kaydedilmektedir.

SQLite içerisinde yalnızca dosyanın fiziksel yolu ve ilişkisel metadata bilgileri saklanır.

Bu yaklaşım:

- veritabanının gereksiz yere büyümesini önler,
- medya dosyalarının yönetimini veritabanından ayırır,
- ilişkisel sorguların medya boyutundan etkilenmesini azaltır.

Dosya sistemi ile SQLite arasında doğrudan atomik transaction kurulamadığı için fotoğraf kayıt ve silme işlemlerinde compensating action / durable cleanup queue yaklaşımı kullanılmaktadır.

### Veritabanı — Drift / SQLite

Uygulamada ilişkisel veri modeli bulunduğu için SQLite tabanlı Drift tercih edilmiştir.

Örnek veri ilişkileri:

```text
Building
   ↓
Floor
   ↓
Room
   ↓
Photo
```

Drift aşağıdaki ihtiyaçlar için kullanılmaktadır:

- type-safe SQL erişimi,
- relational sorgular ve JOIN işlemleri,
- foreign key ilişkileri,
- UNIQUE ve CHECK constraint'leri,
- index yönetimi,
- schema versioning,
- migration yönetimi,
- schema snapshot'ları,
- modular code generation.

### Migration Stratejisi

Database şeması versioned migration yapısı ile yönetilmektedir.

Migration altyapısında:

- version bazlı migration dosyaları,
- Drift schema snapshot'ları,
- generated migration steps,
- populated migration testleri,
- foreign key doğrulamaları

kullanılmaktadır.

Yeni constraint eklenen migration'larda yalnızca boş database yapısı değil, mevcut verinin migration sonrasında korunup korunmadığı da test edilmektedir.

### Ölçeklenebilir Fotoğraf Sorguları

Fotoğraf listelerinde klasik OFFSET pagination yerine cursor / keyset pagination kullanılmaktadır.

Sıralama:

```text
createdAt DESC
id DESC
```

şeklinde deterministik tutulmaktadır.

Bu yaklaşım, veri miktarı büyüdükçe yüksek OFFSET değerlerinin oluşturduğu maliyeti azaltmayı amaçlar.

Grid görünümünde büyük fotoğrafların gereksiz çözünürlükte decode edilmesini önlemek için `cacheWidth` kullanılmaktadır.

### State Management

Uygulamanın presentation katmanında `flutter_bloc` üzerinden Cubit kullanılmaktadır.

State yapıları:

- initial,
- loading,
- loaded,
- operation error,
- fatal error,
- pagination loading

gibi durumları birbirinden ayırmaktadır.

CRUD işlemlerinde oluşan geçici hatalarda mevcut UI verisinin kaybolmaması hedeflenmiştir.

### Katmanlama

Projede ihtiyaç duyulan feature'larda dependency separation uygulanmaktadır.

Building feature'ı referans olarak:

```text
UI
 ↓
BuildingCubit
 ↓
BuildingRepository
 ↓
BuildingRepositoryImpl
 ↓
BuildingDao
 ↓
Drift / SQLite
```

yapısını kullanır.

Repository katmanı tüm basit CRUD feature'larına zorunlu olarak uygulanmamış; karmaşıklığın gerçekten gerektirdiği alanlarda kullanılması tercih edilmiştir.

## Veri Bütünlüğü

SQLite seviyesinde çeşitli bütünlük kuralları uygulanmaktadır.

Örnekler:

- foreign key ilişkileri,
- cascade / set-null delete davranışları,
- aynı binada duplicate kat numarasını engelleyen UNIQUE constraint,
- oda alanının pozitif olmasını zorunlu kılan CHECK constraint.

## Photo / Database Consistency

Fotoğraf işlemlerinde filesystem ve SQLite arasında tutarlılığı korumak için ayrı bir persistence katmanı kullanılmaktadır.

### Save

```text
source file
   ↓
application-owned storage
   ↓
SQLite record
```

Database insert başarısız olursa oluşturulan fiziksel dosya temizlenir.

### Delete

```text
photoId
   ↓
SQLite transaction
   ↓
DB row'dan gerçek imagePath okunur
   ↓
photo row silinir
   ↓
cleanup queue oluşturulur
   ↓
filesystem delete
```

Dosya silme başarısız olursa cleanup kaydı kalıcı olarak saklanır ve daha sonra tekrar denenebilir.

## Code Generation

Drift modular code generation kullanılmaktadır.

Bu sayede büyük tek bir generated dosya yerine table ve DAO çıktıları feature bazlı olarak ayrılmaktadır.

Bu yapı gelecekte 50–100+ tablolu projelerde generated code'un yönetilebilir kalmasını hedeflemektedir.

## Test ve CI

Projede unit ve integration testleri bulunmaktadır.

Test kapsamı içerisinde:

- database constraint testleri,
- migration testleri,
- populated migration senaryoları,
- repository testleri,
- Cubit state testleri,
- photo filesystem / database consistency testleri,
- cleanup retry testleri,
- keyset pagination testleri

bulunmaktadır.

GitHub Actions üzerinden:

```text
flutter pub get
build_runner
Drift migration verification
flutter analyze
flutter test
generated diff verification
```

çalıştırılmaktadır.

## Kullanılan Temel Paketler

- `drift`
- `drift_flutter`
- `drift_dev`
- `flutter_bloc`
- `path_provider`
- `image_picker`
- `build_runner`

## Kurulum

Projeyi klonlayın:

```bash
git clone https://github.com/BerkayOL/driftsql.git
cd driftsql
```

Bağımlılıkları yükleyin:

```bash
flutter pub get
```

Generated kodları oluşturun:

```bash
dart run build_runner build
```

Projeyi çalıştırın:

```bash
flutter run
```

Testleri çalıştırın:

```bash
flutter test
```

Database migration bütünlüğünü kontrol edin:

```bash
dart run drift_dev make-migrations
```

## Projenin Amacı

Bu repository production uygulamasının kendisi olmaktan ziyade, daha büyük offline-first Flutter projelerinde kullanılabilecek veri katmanı ve persistence pattern'lerini doğrulayan bir architecture reference PoC olarak geliştirilmiştir.

Amaç maksimum abstraction değil;

- veri bütünlüğü,
- migration güvenliği,
- ölçeklenebilirlik,
- test edilebilirlik,
- filesystem / database consistency,
- sürdürülebilir code generation

konularını gerçek senaryolar üzerinden test etmektir.