import '../data/repositories/media_repository.dart';
import '../data/data_sources/image_data_source.dart';
import '../data/data_sources/video_data_source.dart';
import '../domain/compress_media_usecase.dart';
import '../domain/download_media_usecase.dart';

class DependencyInjection {
  static MediaRepository createMediaRepository() {
    return MediaRepository(
      imageDataSource: ImageDataSource(),
      videoDataSource: VideoDataSource(),
    );
  }

  static CompressMediaUseCase createCompressMediaUseCase() {
    final mediaRepository = createMediaRepository();
    return CompressMediaUseCase(mediaRepository);
  }

  static DownloadMediaUseCase createDownloadMediaUseCase() {
    return DownloadMediaUseCase();
  }
}
