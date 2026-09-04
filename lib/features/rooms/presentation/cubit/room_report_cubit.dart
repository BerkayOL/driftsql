import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dao/room_dao.dart';
import 'room_report_state.dart';

class RoomReportCubit extends Cubit<RoomReportState> {
  final RoomDao _roomDao;
  StreamSubscription<RoomReport>? _reportSubscription;
  StreamSubscription<List<RoomWithLocation>>? _filterSubscription;
  RoomReport? _report;
  List<RoomWithLocation>? _filteredRooms;
  String _countryCode = 'DE';
  int _builtBefore = 1990;

  RoomReportCubit(this._roomDao) : super(const RoomReportLoading());

  Future<void> watch({
    String countryCode = 'DE',
    int builtBefore = 1990,
  }) async {
    _countryCode = countryCode.toUpperCase();
    _builtBefore = builtBefore;
    _filteredRooms = null;
    emit(const RoomReportLoading());
    await _reportSubscription?.cancel();
    await _filterSubscription?.cancel();

    _reportSubscription = _roomDao.watchRoomReport().listen((report) {
      _report = report;
      _emitIfReady();
    }, onError: _onError);
    _filterSubscription = _roomDao
        .watchHeatedRoomsByBuildingCriteria(
          countryCode: _countryCode,
          builtBefore: _builtBefore,
        )
        .listen((rooms) {
          _filteredRooms = rooms;
          _emitIfReady();
        }, onError: _onError);
  }

  void _emitIfReady() {
    if (!isClosed && _report != null && _filteredRooms != null) {
      emit(
        RoomReportLoaded(
          report: _report!,
          filteredRooms: _filteredRooms!,
          countryCode: _countryCode,
          builtBefore: _builtBefore,
        ),
      );
    }
  }

  void _onError(Object error, StackTrace stackTrace) {
    if (!isClosed) {
      emit(RoomReportError('Rapor yüklenirken hata oluştu: $error'));
    }
  }

  @override
  Future<void> close() async {
    await _reportSubscription?.cancel();
    await _filterSubscription?.cancel();
    return super.close();
  }
}
