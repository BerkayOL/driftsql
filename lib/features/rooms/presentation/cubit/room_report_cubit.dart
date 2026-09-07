import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dao/room_dao.dart';
import 'room_report_state.dart';

class RoomReportCubit extends Cubit<RoomReportState> {
  /// SQL rapor ve filtre sorgularının bulunduğu veri erişim katmanı.
  final RoomDao _roomDao;

  // Rapor ekranı iki bağımsız reactive sorguyu aynı anda dinler:
  // 1) bütün odaların COUNT/SUM/AVG özeti,
  // 2) seçilen ülke ve yıldaki ısıtılan odaların JOIN sonucu.
  StreamSubscription<RoomReport>? _reportSubscription;
  StreamSubscription<List<RoomWithLocation>>? _filterSubscription;

  // İki stream farklı zamanlarda veri gönderebileceği için son değerlerini
  // burada saklarız. UI'a ancak ikisi de hazır olduğunda tek state gönderilir.
  RoomReport? _report;
  List<RoomWithLocation>? _filteredRooms;

  // Ekran ilk açıldığında kullanılacak varsayılan filtre.
  String _countryCode = 'DE';
  int _builtBefore = 1990;

  RoomReportCubit(this._roomDao) : super(const RoomReportLoading());

  Future<void> watch({
    String countryCode = 'DE',
    int builtBefore = 1990,
  }) async {
    // Ülke kodlarını veritabanındaki standart biçimle eşleşmesi için büyütürüz.
    _countryCode = countryCode.toUpperCase();
    _builtBefore = builtBefore;

    // Eski filtre listesinin yeni genel raporla birleşmesini engeller.
    _filteredRooms = null;
    emit(const RoomReportLoading());

    // Filtre yeniden uygulandığında önceki sorgular açık bırakılmaz.
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
    // `!` operatörlerini güvenle kullanabiliriz; aynı koşul içinde iki alanın
    // da null olmadığı açıkça kontrol edilmiştir.
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
    // Her iki stream aynı hata işleyicisini kullanır; ayrıntı kullanıcıya
    // RoomReportError state'i üzerinden iletilir.
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
