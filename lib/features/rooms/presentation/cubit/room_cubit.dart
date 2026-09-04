import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dao/room_dao.dart';
import 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  final RoomDao _roomDao;
  StreamSubscription<List<RoomWithLocation>>? _subscription;

  RoomCubit(this._roomDao) : super(const RoomInitial());

  Future<void> watchRooms(int floorId) async {
    emit(const RoomLoading());
    await _subscription?.cancel();
    _subscription = _roomDao
        .watchRoomsWithLocation(floorId: floorId)
        .listen(
          (rooms) {
            if (!isClosed) {
              emit(RoomLoaded(rooms));
            }
          },
          onError: (Object error, StackTrace stackTrace) {
            if (!isClosed) {
              emit(RoomError('Odalar yüklenirken hata oluştu: $error'));
            }
          },
        );
  }

  Future<void> addRoom({
    required int floorId,
    required String name,
    required bool isHeated,
    required double? targetTemperature,
    required double area,
  }) async {
    try {
      await _roomDao.insertRoom(
        floorId: floorId,
        name: name.trim(),
        isHeated: isHeated,
        targetTemperature: targetTemperature,
        area: area,
      );
      // Manuel reload yok; DAO'daki .watch() değişikliği yayınlar.
    } catch (error) {
      if (!isClosed) {
        emit(RoomError('Oda eklenirken hata oluştu: $error'));
      }
    }
  }

  Future<void> deleteRoom(int id) async {
    try {
      await _roomDao.deleteRoomById(id);
    } catch (error) {
      if (!isClosed) {
        emit(RoomError('Oda silinirken hata oluştu: $error'));
      }
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
