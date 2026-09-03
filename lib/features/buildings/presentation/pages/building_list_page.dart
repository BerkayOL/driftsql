import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/building_cubit.dart';
import '../cubit/building_state.dart';

class BuildingListPage extends StatefulWidget {
  const BuildingListPage({super.key});

  @override
  State<BuildingListPage> createState() => _BuildingListPageState();
}

class _BuildingListPageState extends State<BuildingListPage> {
  @override
  void initState() {
    super.initState();

    // Sayfa ilk açıldığında bütün binaları
    // reactive olarak izlemeye başlıyoruz.
    context.read<BuildingCubit>().watchAllBuildings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Binalar'),
        actions: [
          // Filtreleme ekranını açar.
          IconButton(
            tooltip: 'Filtrele',
            onPressed: () => _showFilterDialog(context),
            icon: const Icon(Icons.filter_alt),
          ),

          // Aktif filtreyi kaldırıp bütün binaları gösterir.
          IconButton(
            tooltip: 'Filtreyi Temizle',
            onPressed: () {
              context.read<BuildingCubit>().watchAllBuildings();
            },
            icon: const Icon(Icons.filter_alt_off),
          ),
        ],
      ),

      body: BlocConsumer<BuildingCubit, BuildingState>(
        listener: (context, state) {
          if (state is BuildingError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        builder: (context, state) {
          if (state is BuildingInitial || state is BuildingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BuildingLoaded) {
            return Column(
              children: [
                // Eğer filtre aktifse kullanıcıya
                // hangi filtrenin uygulandığını gösteriyoruz.
                if (state.isFiltered)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Filtre: ${state.countryCode} - '
                      '${state.builtBefore} öncesi',
                      textAlign: TextAlign.center,
                    ),
                  ),

                Expanded(
                  child: state.buildings.isEmpty
                      ? const Center(
                          child: Text('Kriterlere uygun bina bulunamadı.'),
                        )
                      : ListView.builder(
                          itemCount: state.buildings.length,
                          itemBuilder: (context, index) {
                            final building = state.buildings[index];

                            return ListTile(
                              leading: const Icon(Icons.apartment),

                              title: Text(building.name),

                              subtitle: Text(
                                '${building.countryCode} • '
                                '${building.constructionYear}',
                              ),

                              // Test uygulamasında hızlıca
                              // silme işlemini görebilmek için.
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () {
                                  context.read<BuildingCubit>().deleteBuilding(
                                    building.id,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddBuildingDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Yeni bina eklemek için basit test dialog'u.
  Future<void> _showAddBuildingDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final countryController = TextEditingController();
    final yearController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Bina Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Bina adı',
                  hintText: 'Berlin Test Binası',
                ),
              ),
              TextField(
                controller: countryController,
                maxLength: 2,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Ülke kodu',
                  hintText: 'DE',
                ),
              ),
              TextField(
                controller: yearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Yapım yılı',
                  hintText: '1985',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('İptal'),
            ),
            FilledButton(
              onPressed: () {
                final name = nameController.text.trim();
                final country = countryController.text.trim();
                final year = int.tryParse(yearController.text);

                if (name.isEmpty || country.length != 2 || year == null) {
                  return;
                }

                context.read<BuildingCubit>().addBuilding(
                  name: name,
                  countryCode: country,
                  constructionYear: year,
                );

                Navigator.pop(dialogContext);
              },
              child: const Text('Kaydet'),
            ),
          ],
        );
      },
    );

    nameController.dispose();
    countryController.dispose();
    yearController.dispose();
  }

  /// Ülke + yapım yılı filtresini test ettiğimiz dialog.
  Future<void> _showFilterDialog(BuildContext context) async {
    final countryController = TextEditingController(text: 'DE');

    final yearController = TextEditingController(text: '1990');

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Binaları Filtrele'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: countryController,
                maxLength: 2,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(labelText: 'Ülke kodu'),
              ),
              TextField(
                controller: yearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Bu yıldan önce'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('İptal'),
            ),
            FilledButton(
              onPressed: () {
                final country = countryController.text.trim();

                final year = int.tryParse(yearController.text);

                if (country.length != 2 || year == null) {
                  return;
                }

                context.read<BuildingCubit>().watchFilteredBuildings(
                  countryCode: country,
                  builtBefore: year,
                );

                Navigator.pop(dialogContext);
              },
              child: const Text('Filtrele'),
            ),
          ],
        );
      },
    );

    countryController.dispose();
    yearController.dispose();
  }
}
