import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:image_gallery_saver/image_gallery_saver.dart';

class DownloadMediaUseCase {
  Future<String> execute(String mediaPath) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = mediaPath.split('/').last;
    final filePath = '${directory.path}/$fileName';

   
    final imageFile = File(mediaPath);
    final imageBytes = await imageFile.readAsBytes();
    final image = img.decodeImage(imageBytes);


    final compressedImage = img.encodeJpg(image!, quality: 85);

  
    final compressedFile = File(filePath);
    await compressedFile.writeAsBytes(compressedImage);


    final result = await ImageGallerySaver.saveFile(filePath);
    print("File saved to gallery: $result");

    return filePath;
  }
}
