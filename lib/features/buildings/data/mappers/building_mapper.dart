import '../../domain/models/building.dart';
import '../buildings_table.drift.dart';

extension BuildingsTableDataMapper on BuildingsTableData {
  Building toDomain() {
    return Building(
      id: id,
      name: name,
      countryCode: countryCode,
      constructionYear: constructionYear,
      createdAt: createdAt,
    );
  }
}
