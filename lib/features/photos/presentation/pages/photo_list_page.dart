import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../cubit/photo_cubit.dart';
import '../cubit/photo_state.dart';

class PhotoListPage extends StatefulWidget {
  const PhotoListPage({super.key});

  @override
  State<PhotoListPage> createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  @override
  void initState() {
    super.initState();
    // Ekran açıldığında fotoğrafları yükle
    context.read<PhotoCubit>().loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fotoğraflar')),
      // BlocConsumer, hem state'i dinler hem de UI'yi günceller.
      body: BlocConsumer<PhotoCubit, PhotoState>(
        listener: (context, state) {
          // Eğer state PhotoError ise, ekranda bir SnackBar göster
          if (state is PhotoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
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
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // yan yana 2 fotoğraf
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: state.photos.length,
              itemBuilder: (context, index) {
                final photo = state.photos[index];

                return ClipRRect(
                  // File ile fotoğrafın yolunu veriyoruz ve ekranda gösteriyoruz.
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(File(photo.imagePath), fit: BoxFit.cover),
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
              context.read<PhotoCubit>().pickAndSavePhoto(ImageSource.camera);
            },
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'gallery_btn',
            onPressed: () {
              // Cubit'teki fotoğraf çekme fonksiyonunu tetikliyoruz (Galeri modunda)
              context.read<PhotoCubit>().pickAndSavePhoto(ImageSource.gallery);
            },
            tooltip: 'Galeri',
            child: const Icon(Icons.photo_library),
          ),
        ],
      ),
    );
  }
}
