import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dao/floor_dao.dart';
import 'floor_state.dart';

class FloorCubit extends Cubit<FloorState> {
  final FloorDao _floorDao;
  StreamSubscription<List<FloorWithBuilding>>? _floorsSubscription;

  FloorCubit(this._floorDao) : super(const FloorInitial());

  /// JOIN sorgusunun reactive sonucunu dinler.
  /// Cubit'in içinde doğrudan Drift sorgusu bulunmaz.
  Future<void> watchFloors(int buildingId) async {
    emit(const FloorLoading());
    await _floorsSubscription?.cancel();

    _floorsSubscription = _floorDao
        .watchFloorsWithBuilding(buildingId)
        .listen(
          (floors) {
            if (!isClosed) {
              emit(FloorLoaded(floors));
            }
          },
          onError: (Object error, StackTrace stackTrace) {
            if (!isClosed) {
              emit(FloorError('Katlar yüklenirken hata oluştu: $error'));
            }
          },
        );
  }

  Future<void> addFloor({
    required int buildingId,
    required String name,
    required int floorNumber,
  }) async {
    try {
      await _floorDao.insertFloor(
        buildingId: buildingId,
        name: name.trim(),
        floorNumber: floorNumber,
      );

      // Manuel yenileme yok: DAO'daki `.watch()` INSERT'i algılar.
    } catch (error) {
      if (!isClosed) {
        emit(FloorError('Kat eklenirken hata oluştu: $error'));
      }
    }
  }

  Future<void> deleteFloor(int id) async {
    try {
      await _floorDao.deleteFloorById(id);

      // Manuel yenileme yok: DAO'daki `.watch()` DELETE'i algılar.
    } catch (error) {
      if (!isClosed) {
        emit(FloorError('Kat silinirken hata oluştu: $error'));
      }
    }
  }

  @override
  Future<void> close() async {
    await _floorsSubscription?.cancel();
    return super.close();
  }
}
