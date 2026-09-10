import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/buildings_table.drift.dart';
import '../../data/dao/building_dao.dart';
import 'building_state.dart';

class BuildingCubit extends Cubit<BuildingState> {
  /// Database sorguları doğrudan Cubit içerisinde yazılmaz.
  /// BuildingDao bu sorumluluğu üstlenir.
  final BuildingDao _buildingDao;

  /// Drift'in reactive Stream'ini dinlediğimiz subscription.
  ///
  /// Filtre değiştiğinde eski sorguyu bırakıp
  /// yeni sorguyu dinlememizi sağlar.
  StreamSubscription<List<BuildingsTableData>>? _buildingsSubscription;

  BuildingCubit(this._buildingDao) : super(const BuildingInitial());

  /// Bütün binaları reactive olarak izlemeye başlar.
  Future<void> watchAllBuildings() async {
    emit(const BuildingLoading());

    // Daha önce başka bir bina sorgusu dinleniyorsa kapatıyoruz.
    await _buildingsSubscription?.cancel();

    _buildingsSubscription = _buildingDao.watchAllBuildings().listen(
      (buildings) {
        if (!isClosed) {
          emit(BuildingLoaded(buildings));
        }
      },
      onError: (Object error, StackTrace stackTrace) {
        if (!isClosed) {
          emit(BuildingError('Binalar yüklenirken hata oluştu: $error'));
        }
      },
    );
  }

  /// Belirli ülke ve yapım yılına göre binaları filtreler.
  ///
  /// Örnek:
  ///
  /// countryCode = DE
  /// builtBefore = 1990
  ///
  /// Sonuç:
  /// Almanya'da 1990'dan önce yapılmış binalar.
  Future<void> watchFilteredBuildings({
    required String countryCode,
    required int builtBefore,
  }) async {
    emit(const BuildingLoading());

    await _buildingsSubscription?.cancel();

    // Kullanıcının "de", "De", " DE " gibi girişlerini
    // standart "DE" formatına dönüştürüyoruz.
    final normalizedCountryCode = countryCode.trim().toUpperCase();

    _buildingsSubscription = _buildingDao
        .watchBuildingsByCountryAndYear(
          countryCode: normalizedCountryCode,
          builtBefore: builtBefore,
        )
        .listen(
          (buildings) {
            if (!isClosed) {
              emit(
                BuildingLoaded(
                  buildings,
                  isFiltered: true,
                  countryCode: normalizedCountryCode,
                  builtBefore: builtBefore,
                ),
              );
            }
          },
          onError: (Object error, StackTrace stackTrace) {
            if (!isClosed) {
              emit(BuildingError('Binalar filtrelenirken hata oluştu: $error'));
            }
          },
        );
  }

  /// Yeni bina ekler.
  ///
  /// INSERT sonrasında listeyi tekrar elle çağırmıyoruz.
  /// Çünkü DAO'daki .watch() sorgusu database değişikliğini
  /// otomatik olarak algılar.
  Future<void> addBuilding({
    required String name,
    required String countryCode,
    required int constructionYear,
  }) async {
    try {
      await _buildingDao.insertBuilding(
        name: name.trim(),
        countryCode: countryCode.trim().toUpperCase(),
        constructionYear: constructionYear,
      );

      // loadBuildings() yok!
      //
      // Drift .watch() INSERT'i fark edip
      // güncel listeyi otomatik yayınlayacak.
    } catch (e) {
      if (!isClosed) {
        _emitOperationError('Bina eklenirken hata oluştu: $e');
      }
    }
  }

  /// ID'si verilen binayı database'den siler.
  Future<void> deleteBuilding(int id) async {
    try {
      await _buildingDao.deleteBuildingById(id);

      // Burada da manuel reload yok.
      // Drift .watch() DELETE işlemini fark edecek.
    } catch (e) {
      if (!isClosed) {
        _emitOperationError('Bina silinirken hata oluştu: $e');
      }
    }
  }

  /// Cubit'e operationError mesajı göndermek için küçük bir helper.
  void _emitOperationError(String message) {
    if (isClosed) {
      return;
    }

    final currentState = state;

    if (currentState is BuildingLoaded) {
      emit(currentState.copyWith(operationError: message));
    } else {
      emit(BuildingError(message));
    }
  }

  void clearOperationError() {
    final currentState = state;

    if (currentState is BuildingLoaded &&
        currentState.operationError != null &&
        !isClosed) {
      emit(currentState.copyWith(clearOperationError: true));
    }
  }

  /// Cubit kapatıldığında database Stream aboneliğini de kapatıyoruz.
  @override
  Future<void> close() async {
    await _buildingsSubscription?.cancel();
    return super.close();
  }
}
