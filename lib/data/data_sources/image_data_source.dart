import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import '../models/media_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ImageDataSource {
  final ImagePicker _picker = ImagePicker();

  Future<MediaModel?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return MediaModel(path: pickedFile.path, isVideo: false);
    }
    return null;
  }

  Future<List<String>> compressImage(String path) async {
    final imageFile = File(path);
    final imageBytes = await imageFile.readAsBytes();
    final image = img.decodeImage(imageBytes);

    List<int> qualities = [30, 50, 70];
    List<String> compressedFilePaths = [];

    final directory = await getApplicationDocumentsDirectory();

    for (int quality in qualities) {
      final compressedImage = img.encodeJpg(image!, quality: quality);

      final compressedFilePath =
          '${directory.path}/compressed_${quality}_${imageFile.uri.pathSegments.last}';
      final compressedFile = File(compressedFilePath);
      await compressedFile.writeAsBytes(compressedImage);

      compressedFilePaths.add(compressedFilePath);
    }

    return compressedFilePaths;
  }
}
