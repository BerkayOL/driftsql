import '../dao/photo_dao.dart';

final class PhotoCursor {
  final DateTime createdAt;
  final int id;

  const PhotoCursor({required this.createdAt, required this.id});
}

final class PhotoPage {
  final List<PhotoWithLocation> items;
  final PhotoCursor? nextCursor;
  final bool hasMore;

  const PhotoPage({
    required this.items,
    required this.nextCursor,
    required this.hasMore,
  });
}
