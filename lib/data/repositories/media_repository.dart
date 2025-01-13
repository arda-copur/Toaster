import '../data_sources/image_data_source.dart';
import '../data_sources/video_data_source.dart';
import '../models/media_model.dart';

class MediaRepository {
  final ImageDataSource imageDataSource;
  final VideoDataSource videoDataSource;

  MediaRepository(
      {required this.imageDataSource, required this.videoDataSource});

  Future<MediaModel?> pickImage() async {
    return await imageDataSource.pickImage();
  }

  Future<MediaModel?> pickVideo() async {
    return await videoDataSource.pickVideo();
  }

  Future<List<String>> compressImage(String path) async {
    return await imageDataSource.compressImage(path);
  }

  Future<String?> compressVideo(String path) async {
    return await videoDataSource.compressVideo(path);
  }
}
