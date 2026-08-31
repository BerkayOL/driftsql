import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/database/app_database.dart';
import 'features/photos/presentation/cubit/photo_cubit.dart';
import 'features/photos/presentation/pages/photo_list_page.dart';

void main() {
  // 1. Flutter'ın servislerle iletişim kurabilmesi için gerekli olan kodu çalıştırıyoruz.
  WidgetsFlutterBinding.ensureInitialized();

  // Drift veri tabanını başlatıyoruz.
  final appDatabase = AppDatabase();

  // Veri tabanını içeriye yolluyoruz ve uygulamayı başlatıyoruz.
  runApp(MyApp(database: appDatabase));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotoCubit(database),
      child: MaterialApp(
        title: 'LiDAR Offline Photo App',
        // Debug modunda sağ üst köşede çıkan "Debug" yazısını kaldırıyoruz.
        debugShowCheckedModeBanner: false,

        // Material 3 Tasarımını kullanıyoruz.
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepPurple,
        ),
        // Uygulama açıldığında ilk olarak PhotoListPage sayfasını gösteriyoruz.
        home: const PhotoListPage(),
      ),
    );
  }
}
