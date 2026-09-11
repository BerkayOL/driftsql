import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/database/app_database.dart';

import 'features/buildings/presentation/cubit/building_cubit.dart';
import 'features/floors/presentation/cubit/floor_cubit.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/photos/presentation/cubit/photo_cubit.dart';

import 'features/buildings/data/repositories/building_repository_impl.dart';
import 'features/buildings/domain/repositories/building_repository.dart';

void main() {
  // Database açılmadan önce Flutter'ın platform servislerini hazırlarız.
  // path_provider ve SQLite gibi eklentiler bu bağlantıya ihtiyaç duyar.
  WidgetsFlutterBinding.ensureInitialized();

  /// Uygulamanın local SQLite database'ini oluşturuyoruz.
  final appDatabase = AppDatabase.defaults();

  runApp(MyApp(database: appDatabase));
}

class MyApp extends StatelessWidget {
  /// Uygulama boyunca paylaşılacak tek database örneği.
  /// Her sayfanın ayrı bağlantı açmasını önlemek için üst seviyede oluşturulur.
  final AppDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppDatabase>.value(value: database),

        RepositoryProvider<BuildingRepository>(
          create: (_) => BuildingRepositoryImpl(database.buildingDao),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                BuildingCubit(context.read<BuildingRepository>()),
          ),
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
