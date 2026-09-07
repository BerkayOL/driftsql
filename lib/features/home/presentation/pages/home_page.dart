import 'package:flutter/material.dart';

import '../../../buildings/presentation/pages/building_list_page.dart';
import '../../../photos/presentation/pages/photo_list_page.dart';
import '../../../rooms/presentation/pages/room_report_page.dart';

/// Uygulamanın üç ana bölümünü alt navigasyon ile bir araya getiren kabuk sayfa.
///
/// Veritabanı işlemi yapmaz; yalnızca hangi ana sayfanın görünür olduğunu tutar.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Alt menüde seçili olan sayfanın indeksidir.
  /// 0: Binalar, 1: Fotoğraflar, 2: Rapor.
  int _currentIndex = 0;

  /// Sayfaları her sekme değişiminde yeniden oluşturmak yerine aynı widget
  /// örneklerini IndexedStack içinde saklıyoruz.
  static const _pages = [BuildingListPage(), PhotoListPage(), RoomReportPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack yalnızca seçili çocuğu gösterir; diğer sayfaları widget
      // ağacında tuttuğu için sekmelerin mevcut durumu korunur.
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          // setState çağrısı HomePage'i yeniden çizerek IndexedStack'in
          // göstereceği çocuğu değiştirir.
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.apartment_outlined),
            selectedIcon: Icon(Icons.apartment),
            label: 'Binalar',
          ),
          NavigationDestination(
            icon: Icon(Icons.photo_outlined),
            selectedIcon: Icon(Icons.photo),
            label: 'Fotoğraflar',
          ),
          NavigationDestination(
            icon: Icon(Icons.query_stats_outlined),
            selectedIcon: Icon(Icons.query_stats),
            label: 'Rapor',
          ),
        ],
      ),
    );
  }
}
