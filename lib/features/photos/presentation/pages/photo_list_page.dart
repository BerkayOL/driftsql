import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../cubit/photo_cubit.dart';
import '../cubit/photo_state.dart';

/// Tüm fotoğrafları veya `roomId` verilmişse tek odanın fotoğraflarını gösterir.
///
/// `roomId == null` olduğunda genel Fotoğraflar sekmesi olarak çalışır.
class PhotoListPage extends StatefulWidget {
  final int? roomId;
  final String? roomName;

  const PhotoListPage({super.key, this.roomId, this.roomName});

  @override
  State<PhotoListPage> createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    context.read<PhotoCubit>().loadInitialPage(roomId: widget.roomId);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    // Listenin sonuna yaklaşık 500px kala
    // sonraki sayfayı önceden yüklemeye başlarız.
    if (position.pixels >= position.maxScrollExtent - 500) {
      context.read<PhotoCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.roomName == null
              ? 'Fotoğraflar'
              : '${widget.roomName} Fotoğrafları',
        ),
      ),
      // BlocConsumer, hem state'i dinler hem de UI'yi günceller.
      body: BlocConsumer<PhotoCubit, PhotoState>(
        listener: (context, state) {
          if (state is PhotoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is PhotoLoaded && state.operationError != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.operationError!)));
          }
        },
        builder: (context, state) {
          // Eğer durum Başlangıç veya Yükleniyor ise, ekranda bir yükleniyor göstergesi göster
          if (state is PhotoInitial || state is PhotoLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // Eğer durum Fotoğraflar Yüklendi ise, ekranda fotoğrafları listele
          else if (state is PhotoLoaded) {
            if (state.photos.isEmpty) {
              return const Center(child: Text('Henüz fotoğraf yok.'));
            }

            // Fotoğrafları 2'li kutular halinde diziyoruz.
            return GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // yan yana 2 fotoğraf
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: state.photos.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.photos.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final result = state.photos[index];
                final photo = result.photo;

                // Tarihi GG/AA/YYYY formatına çeviriyoruz.
                final formattedDate =
                    "${photo.createdAt.day.toString().padLeft(2, '0')}.${photo.createdAt.month.toString().padLeft(2, '0')}.${photo.createdAt.year}";

                return GestureDetector(
                  onTap: () {
                    // Fotoğrafa tıklandığında ekranın tamamını kaplayan bir Dialog açılır
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: Colors.black87,
                        insetPadding: EdgeInsets
                            .zero, // Kenar boşluklarını sıfırla (Tam Ekran)
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // InteractiveViewer: Fotoğrafa iki parmakla zoom yapılmasını sağlar!
                            InteractiveViewer(
                              child: Image.file(
                                File(photo.imagePath),
                                fit: BoxFit
                                    .contain, // Ekrana sığacak şekilde ortala
                              ),
                            ),
                            // Sağ üste bir kapatma butonu ekleyelim
                            Positioned(
                              top: 40,
                              right: 20,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  onLongPress: () {
                    // Yanlışlıkla silmeyi azaltmak için işlem önce kullanıcıya
                    // onaylatılır, ardından Cubit üzerinden gerçekleştirilir.
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Fotoğrafı Sil'),
                        content: const Text(
                          'Bu fotoğrafı silmek istediğinize emin misiniz?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('İptal'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Diyalogu kapat
                              // Cubit'teki silme fonksiyonunu tetikle
                              context.read<PhotoCubit>().deletePhoto(result);
                            },
                            child: const Text(
                              'Sil',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  // FOTOĞRAF ve TARİH GÖRÜNÜMÜ
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Arka planda fotoğraf
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final devicePixelRatio =
                                MediaQuery.devicePixelRatioOf(context);

                            final targetWidth =
                                (constraints.maxWidth * devicePixelRatio)
                                    .round()
                                    .clamp(1, 1024)
                                    .toInt();

                            return Image.file(
                              File(photo.imagePath),
                              fit: BoxFit.cover,

                              // Grid için yalnızca ihtiyaç duyulan çözünürlükte decode edilir.
                              cacheWidth: targetWidth,

                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(Icons.broken_image_outlined),
                                );
                              },
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color:
                                Colors.black54, // yarı saydam siyah arka plan
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              result.room == null
                                  ? '$formattedDate • Atanmamış'
                                  : '$formattedDate • ${result.building!.name} / '
                                        '${result.floor!.name} / ${result.room!.name}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          // Hiçbir duruma uymuyorsa boş bir alan döndür.
          return const SizedBox.shrink();
        },
      ),

      // Fotoğraf ekleme butonları (Kamera ve Galeri)
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'camera_btn',
            onPressed: () {
              // Cubit'teki fotoğraf çekme fonksiyonunu tetikliyoruz (Kamera modunda)
              context.read<PhotoCubit>().pickAndSavePhoto(
                ImageSource.camera,
                roomId: widget.roomId,
              );
            },
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'gallery_btn',
            onPressed: () {
              // Cubit'teki fotoğraf çekme fonksiyonunu tetikliyoruz (Galeri modunda)
              context.read<PhotoCubit>().pickAndSavePhoto(
                ImageSource.gallery,
                roomId: widget.roomId,
              );
            },
            tooltip: 'Galeri',
            child: const Icon(Icons.photo_library),
          ),
        ],
      ),
    );
  }
}
