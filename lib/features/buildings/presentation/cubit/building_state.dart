import '../../data/buildings_table.drift.dart';

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

  /// Ekleme/silme gibi işlemlerde oluşan geçici hata.
  /// Mevcut listeyi kaybetmeden UI'a bildirir.
  final String? operationError;
  const BuildingLoaded(
    this.buildings, {
    this.isFiltered = false,
    this.countryCode,
    this.operationError,
    this.builtBefore,
  });
  BuildingLoaded copyWith({
    List<BuildingsTableData>? buildings,
    bool? isFiltered,
    String? countryCode,
    int? builtBefore,
    String? operationError,
    bool clearOperationError = false,
  }) {
    return BuildingLoaded(
      buildings ?? this.buildings,
      isFiltered: isFiltered ?? this.isFiltered,
      countryCode: countryCode ?? this.countryCode,
      builtBefore: builtBefore ?? this.builtBefore,
      operationError: clearOperationError
          ? null
          : operationError ?? this.operationError,
    );
  }
}

/// Database veya başka bir işlem sırasında hata oluşursa kullanılır.
final class BuildingError extends BuildingState {
  final String message;

  const BuildingError(this.message);
}
