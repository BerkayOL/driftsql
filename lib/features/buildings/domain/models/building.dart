final class Building {
  final int id;
  final String name;
  final String countryCode;
  final int constructionYear;
  final DateTime createdAt;

  const Building({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.constructionYear,
    required this.createdAt,
  });
}
