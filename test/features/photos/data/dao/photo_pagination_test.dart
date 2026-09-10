import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:driftsql/core/database/app_database.dart';
import 'package:driftsql/features/photos/data/dao/photo_dao.dart';

void main() {
  late AppDatabase database;
  late PhotoDao photoDao;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    photoDao = database.photoDao;
  });

  tearDown(() async {
    await database.close();
  });

  test('first page respects page size and reports more data', () async {
    for (var i = 0; i < 65; i++) {
      await photoDao.insertPhoto(imagePath: 'photo_$i.jpg');
    }

    final page = await photoDao.getPhotosPage(pageSize: 30);

    expect(page.items, hasLength(30));
    expect(page.hasMore, isTrue);
    expect(page.nextCursor, isNotNull);
  });

  test('cursor pagination loads all records without duplicates', () async {
    for (var i = 0; i < 65; i++) {
      await photoDao.insertPhoto(imagePath: 'photo_$i.jpg');
    }

    final firstPage = await photoDao.getPhotosPage(pageSize: 30);

    final secondPage = await photoDao.getPhotosPage(
      pageSize: 30,
      cursor: firstPage.nextCursor,
    );

    final thirdPage = await photoDao.getPhotosPage(
      pageSize: 30,
      cursor: secondPage.nextCursor,
    );

    expect(firstPage.items, hasLength(30));
    expect(secondPage.items, hasLength(30));
    expect(thirdPage.items, hasLength(5));

    expect(firstPage.hasMore, isTrue);
    expect(secondPage.hasMore, isTrue);
    expect(thirdPage.hasMore, isFalse);

    final allIds = [
      ...firstPage.items.map((item) => item.photo.id),
      ...secondPage.items.map((item) => item.photo.id),
      ...thirdPage.items.map((item) => item.photo.id),
    ];

    // 65 kaydın tamamı gelmeli.
    expect(allIds, hasLength(65));

    // Hiçbir fotoğraf iki farklı sayfada tekrar etmemeli.
    expect(allIds.toSet(), hasLength(65));
  });

  test('last page returns null cursor when there are no records', () async {
    final page = await photoDao.getPhotosPage(pageSize: 30);

    expect(page.items, isEmpty);
    expect(page.hasMore, isFalse);
    expect(page.nextCursor, isNull);
  });
}
