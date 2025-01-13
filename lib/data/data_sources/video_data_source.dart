import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import '../models/media_model.dart';

class VideoDataSource {
  final ImagePicker _picker = ImagePicker();

  Future<MediaModel?> pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      return MediaModel(path: pickedFile.path, isVideo: true);
    }
    return null;
  }

  Future<String?> compressVideo(String path) async {
    final compressedFilePath = await VideoCompress.compressVideo(
      path,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
    );
    return compressedFilePath!.path;
  }
}
