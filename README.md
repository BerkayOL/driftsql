## Development

Tested with Flutter 3.44.8 (stable).

Newer stable Flutter versions may also work.

# Lidar Offline Storage PoC

Bu proje, saha operasyonlarında internet bağlantısı olmadan yüksek boyutlu medya dosyalarının cihaz üzerinde saklanması ve yönetilmesi süreçlerini test etmek amacıyla geliştirilmiş bir Proof of Concept (PoC) çalışmasıdır.

## Mimari ve Teknolojik Kararlar

* **Depolama Stratejisi (File System vs. Blob):** Yüksek boyutlu medya dosyalarının veritabanı performansını olumsuz etkilemesini önlemek amacıyla, fotoğraflar `path_provider` aracılığıyla cihazın yerel dosya sistemine kopyalanmaktadır. Veritabanında dosyaların kendisi (Blob) yerine, yalnızca fiziksel dosya yolları (path) ilişkisel veri olarak tutulmaktadır.
* **Veritabanı (Drift / SQLite):** İlerleyen aşamalarda bina, oda ve ölçüm raporları gibi birbirine bağlı (relational) karmaşık veri modellerinin kullanılacağı öngörülerek Isar vb. NoSQL çözümler yerine SQLite tabanlı Drift tercih edilmiştir. Drift'in Isolate yapısı kullanılarak veritabanı işlemlerinin UI thread'i bloklaması engellenmiştir.
* **State Management (Cubit):** Clean Architecture prensiplerine sadık kalınarak, arayüz katmanı ile iş mantığı (Business Logic) birbirinden izole edilmiştir. Uygulamanın asenkron durum yönetimi (yükleniyor, başarılı, hata) `flutter_bloc` paketi üzerinden Cubit ile sağlanmaktadır.

## Kullanılan Temel Paketler

* `drift` & `drift_flutter`
* `flutter_bloc`
* `path_provider`
* `image_picker`

## Kurulum ve Çalıştırma

1. Projeyi klonlayın:
   ```bash
   git clone [https://github.com/BerkayOL/driftsql.git](https://github.com/BerkayOL/driftsql.git)
