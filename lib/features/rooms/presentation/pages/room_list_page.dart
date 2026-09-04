import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../../photos/presentation/cubit/photo_cubit.dart';
import '../../../photos/presentation/pages/photo_list_page.dart';
import '../cubit/room_cubit.dart';
import '../cubit/room_state.dart';

class RoomListPage extends StatefulWidget {
  final int floorId;
  final String floorName;

  const RoomListPage({
    super.key,
    required this.floorId,
    required this.floorName,
  });

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  @override
  void initState() {
    super.initState();
    context.read<RoomCubit>().watchRooms(widget.floorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.floorName} Odaları')),
      body: BlocConsumer<RoomCubit, RoomState>(
        listener: (context, state) {
          if (state is RoomError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is RoomInitial || state is RoomLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RoomLoaded) {
            if (state.rooms.isEmpty) {
              return const Center(child: Text('Bu kata henüz oda eklenmedi.'));
            }
            return ListView.builder(
              itemCount: state.rooms.length,
              itemBuilder: (context, index) {
                final result = state.rooms[index];
                final room = result.room;
                return ListTile(
                  leading: Icon(
                    room.isHeated ? Icons.thermostat : Icons.ac_unit,
                  ),
                  title: Text(room.name),
                  subtitle: Text(
                    '${room.area.toStringAsFixed(1)} m² • '
                    '${room.targetTemperature?.toStringAsFixed(1) ?? '-'} °C\n'
                    '${result.building.name} / ${result.floor.name}',
                  ),
                  isThreeLine: true,
                  onTap: () {
                    final database = context.read<AppDatabase>();
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => BlocProvider(
                          create: (_) => PhotoCubit(database.photoDao),
                          child: PhotoListPage(
                            roomId: room.id,
                            roomName: room.name,
                          ),
                        ),
                      ),
                    );
                  },
                  trailing: IconButton(
                    tooltip: 'Odayı sil',
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () =>
                        context.read<RoomCubit>().deleteRoom(room.id),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRoomDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddRoomDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final areaController = TextEditingController();
    final temperatureController = TextEditingController();
    var isHeated = true;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Oda Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Oda adı'),
              ),
              TextField(
                controller: areaController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Alan (m²)'),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Isıtılan oda'),
                value: isHeated,
                onChanged: (value) => setDialogState(() => isHeated = value),
              ),
              if (isHeated)
                TextField(
                  controller: temperatureController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Hedef sıcaklık',
                  ),
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
                final name = nameController.text.trim();
                final area = double.tryParse(
                  areaController.text.replaceAll(',', '.'),
                );
                final temperature = isHeated
                    ? double.tryParse(
                        temperatureController.text.replaceAll(',', '.'),
                      )
                    : null;
                if (name.isEmpty ||
                    area == null ||
                    (isHeated && temperature == null)) {
                  return;
                }
                context.read<RoomCubit>().addRoom(
                  floorId: widget.floorId,
                  name: name,
                  isHeated: isHeated,
                  targetTemperature: temperature,
                  area: area,
                );
                Navigator.pop(dialogContext);
              },
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );

    nameController.dispose();
    areaController.dispose();
    temperatureController.dispose();
  }
}
