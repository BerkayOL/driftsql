import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../../rooms/presentation/cubit/room_cubit.dart';
import '../../../rooms/presentation/pages/room_list_page.dart';
import '../cubit/floor_cubit.dart';
import '../cubit/floor_state.dart';

class FloorListPage extends StatefulWidget {
  final int buildingId;
  final String buildingName;

  const FloorListPage({
    super.key,
    required this.buildingId,
    required this.buildingName,
  });

  @override
  State<FloorListPage> createState() => _FloorListPageState();
}

class _FloorListPageState extends State<FloorListPage> {
  @override
  void initState() {
    super.initState();
    context.read<FloorCubit>().watchFloors(widget.buildingId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.buildingName} Katları')),
      body: BlocConsumer<FloorCubit, FloorState>(
        listener: (context, state) {
          if (state is FloorError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is FloorInitial || state is FloorLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FloorLoaded) {
            if (state.floors.isEmpty) {
              return const Center(
                child: Text('Bu binaya henüz kat eklenmedi.'),
              );
            }

            return ListView.builder(
              itemCount: state.floors.length,
              itemBuilder: (context, index) {
                final result = state.floors[index];
                final floor = result.floor;

                return ListTile(
                  leading: CircleAvatar(child: Text('${floor.floorNumber}')),
                  title: Text(floor.name),
                  // Bina adı Floor tablosundan değil, JOIN sonucundan gelir.
                  subtitle: Text('Bina: ${result.buildingName}'),
                  onTap: () {
                    final database = context.read<AppDatabase>();
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => BlocProvider(
                          create: (_) => RoomCubit(database.roomDao),
                          child: RoomListPage(
                            floorId: floor.id,
                            floorName: floor.name,
                          ),
                        ),
                      ),
                    );
                  },
                  trailing: IconButton(
                    tooltip: 'Katı sil',
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      context.read<FloorCubit>().deleteFloor(floor.id);
                    },
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddFloorDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddFloorDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final numberController = TextEditingController();
    final firstRoomController = TextEditingController();
    final firstRoomAreaController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Kat Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Kat adı',
                  hintText: 'Zemin Kat',
                ),
              ),
              TextField(
                controller: firstRoomController,
                decoration: const InputDecoration(
                  labelText: 'İlk oda (opsiyonel transaction)',
                ),
              ),
              TextField(
                controller: firstRoomAreaController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'İlk oda alanı'),
              ),
              TextField(
                controller: numberController,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Kat numarası',
                  hintText: '0',
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
                final floorNumber = int.tryParse(numberController.text.trim());
                final firstRoom = firstRoomController.text.trim();
                final firstRoomArea = double.tryParse(
                  firstRoomAreaController.text.trim().replaceAll(',', '.'),
                );

                if (name.isEmpty ||
                    floorNumber == null ||
                    (firstRoom.isNotEmpty && firstRoomArea == null)) {
                  return;
                }

                if (firstRoom.isEmpty) {
                  context.read<FloorCubit>().addFloor(
                    buildingId: widget.buildingId,
                    name: name,
                    floorNumber: floorNumber,
                  );
                } else {
                  context.read<FloorCubit>().addFloorWithFirstRoom(
                    buildingId: widget.buildingId,
                    floorName: name,
                    floorNumber: floorNumber,
                    roomName: firstRoom,
                    roomArea: firstRoomArea!,
                  );
                }
                Navigator.pop(dialogContext);
              },
              child: const Text('Kaydet'),
            ),
          ],
        );
      },
    );

    nameController.dispose();
    numberController.dispose();
    firstRoomController.dispose();
    firstRoomAreaController.dispose();
  }
}
