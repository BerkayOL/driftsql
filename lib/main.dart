import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/database/app_database.dart';

import 'features/buildings/presentation/cubit/building_cubit.dart';
import 'features/floors/presentation/cubit/floor_cubit.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/photos/presentation/cubit/photo_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// Uygulamanın local SQLite database'ini oluşturuyoruz.
  final appDatabase = AppDatabase.defaults();

  runApp(MyApp(database: appDatabase));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    /// Uygulamada artık birden fazla Cubit olduğu için
    /// MultiBlocProvider kullanıyoruz.
    ///
    /// Böylece provider'ları iç içe yazmamıza gerek kalmıyor.
    return RepositoryProvider.value(
      value: database,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => BuildingCubit(database.buildingDao)),
          BlocProvider(create: (_) => FloorCubit(database.floorDao)),
          BlocProvider(create: (_) => PhotoCubit(database.photoDao)),
        ],
        child: MaterialApp(
          title: 'ThermoPlanX Drift Test',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.deepPurple,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
