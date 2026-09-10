import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

typedef PhotoDirectoryProvider = Future<Directory> Function();
typedef PhotoFileNameGenerator = String Function(String sourcePath);
typedef PhotoFileDeleter = Future<void> Function(String filePath);

/// Fotoğrafların fiziksel dosya sistemi işlemlerinden sorumludur.
///
/// Database hakkında hiçbir şey bilmez.
final class PhotoStorageService {
  PhotoStorageService({
    PhotoDirectoryProvider? directoryProvider,
    PhotoFileNameGenerator? fileNameGenerator,
    PhotoFileDeleter? fileDeleter,
  }) : _directoryProvider =
           directoryProvider ?? getApplicationDocumentsDirectory,
       _fileNameGenerator = fileNameGenerator ?? _generateUniqueFileName,
       _fileDeleter = fileDeleter ?? _deleteFileIfExists;

  final PhotoDirectoryProvider _directoryProvider;
  final PhotoFileNameGenerator _fileNameGenerator;
  final PhotoFileDeleter _fileDeleter;

  /// Fotoğrafları uygulamanın kendi kontrollü klasörüne kopyalar.
  Future<File> persistFile(String sourcePath) async {
    final sourceFile = File(sourcePath);

    if (!await sourceFile.exists()) {
      throw FileSystemException('Kaynak fotoğraf bulunamadı.', sourcePath);
    }

    final rootDirectory = await _directoryProvider();

    final photoDirectory = Directory(
      path.join(rootDirectory.path, 'offline_photos'),
    );

    if (!await photoDirectory.exists()) {
      await photoDirectory.create(recursive: true);
    }

    final fileName = _fileNameGenerator(sourcePath);

    final destinationFile = File(path.join(photoDirectory.path, fileName));

    return sourceFile.copy(destinationFile.path);
  }

  /// Dosya mevcutsa siler.
  ///
  /// Zaten yoksa hata üretmez.
  Future<void> deleteIfExists(String filePath) {
    return _fileDeleter(filePath);
  }

  static Future<void> _deleteFileIfExists(String filePath) async {
    final file = File(filePath);

    if (await file.exists()) {
      await file.delete();
    }
  }

  static String _generateUniqueFileName(String sourcePath) {
    final random = Random.secure();

    final randomToken = List.generate(
      4,
      (_) => random.nextInt(1 << 16).toRadixString(16).padLeft(4, '0'),
    ).join();

    final extension = path.extension(sourcePath).toLowerCase();

    return 'photo_'
        '${DateTime.now().microsecondsSinceEpoch}_'
        '$randomToken'
        '$extension';
  }
}
