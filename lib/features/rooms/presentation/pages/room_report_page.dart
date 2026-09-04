import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../cubit/room_report_cubit.dart';
import '../cubit/room_report_state.dart';

class RoomReportPage extends StatelessWidget {
  const RoomReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RoomReportCubit(context.read<AppDatabase>().roomDao)..watch(),
      child: const _RoomReportView(),
    );
  }
}

class _RoomReportView extends StatelessWidget {
  const _RoomReportView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İlişkisel Rapor'),
        actions: [
          IconButton(
            tooltip: 'Filtreyi değiştir',
            icon: const Icon(Icons.filter_alt),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<RoomReportCubit, RoomReportState>(
        builder: (context, state) {
          if (state is RoomReportLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RoomReportError) {
            return Center(child: Text(state.message));
          }
          final loaded = state as RoomReportLoaded;
          final report = loaded.report;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('COUNT oda sayısı: ${report.roomCount}'),
              Text(
                'SUM toplam alan: ${report.totalArea.toStringAsFixed(1)} m²',
              ),
              Text(
                'AVG hedef sıcaklık: '
                '${report.averageTargetTemperature?.toStringAsFixed(1) ?? '-'} °C',
              ),
              const Divider(height: 32),
              Text(
                '${loaded.countryCode} ülkesinde ${loaded.builtBefore} öncesi '
                'binalardaki ısıtılan odalar',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              if (loaded.filteredRooms.isEmpty)
                const Text('Filtreye uygun oda yok.'),
              for (final item in loaded.filteredRooms)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(item.room.name),
                  subtitle: Text('${item.building.name} / ${item.floor.name}'),
                  trailing: Text('${item.room.area.toStringAsFixed(1)} m²'),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showFilterDialog(BuildContext context) async {
    final current = context.read<RoomReportCubit>().state;
    final countryController = TextEditingController(
      text: current is RoomReportLoaded ? current.countryCode : 'DE',
    );
    final yearController = TextEditingController(
      text: current is RoomReportLoaded ? '${current.builtBefore}' : '1990',
    );
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Oda Filtresi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: countryController,
              maxLength: 2,
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
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('İptal'),
          ),
          FilledButton(
            onPressed: () {
              final country = countryController.text.trim();
              final year = int.tryParse(yearController.text.trim());
              if (country.length != 2 || year == null) return;
              context.read<RoomReportCubit>().watch(
                countryCode: country,
                builtBefore: year,
              );
              Navigator.pop(dialogContext);
            },
            child: const Text('Uygula'),
          ),
        ],
      ),
    );
    countryController.dispose();
    yearController.dispose();
  }
}
