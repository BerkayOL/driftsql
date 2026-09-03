import '../../../../core/database/app_database.dart';

/// Building özelliğinde UI'ın bulunabileceği bütün durumların
/// temel sınıfıdır.
sealed class BuildingState {
  const BuildingState();
}

/// Cubit ilk oluşturulduğundaki başlangıç durumu.
final class BuildingInitial extends BuildingState {
  const BuildingInitial();
}

/// Binalar database'den yüklenirken kullanılır.
final class BuildingLoading extends BuildingState {
  const BuildingLoading();
}

/// Binalar başarıyla geldiğinde kullanılır.
final class BuildingLoaded extends BuildingState {
  final List<BuildingsTableData> buildings;

  /// Şu anda filtre uygulanıp uygulanmadığını UI'ın bilmesi için tutulur.
  final bool isFiltered;

  /// Filtre aktifse hangi ülkenin seçildiğini tutar.
  final String? countryCode;

  /// Filtre aktifse hangi yıldan önceki binaların getirildiğini tutar.
  final int? builtBefore;

  const BuildingLoaded(
    this.buildings, {
    this.isFiltered = false,
    this.countryCode,
    this.builtBefore,
  });
}

/// Database veya başka bir işlem sırasında hata oluşursa kullanılır.
final class BuildingError extends BuildingState {
  final String message;

  const BuildingError(this.message);
}
