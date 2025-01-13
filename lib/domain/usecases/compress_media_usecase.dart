import '../../data/repositories/media_repository.dart';

class CompressMediaUseCase {
  final MediaRepository repository;

  CompressMediaUseCase(this.repository);

  Future<Object?> execute(String path, bool isVideo) {
    return isVideo
        ? repository.compressVideo(path)
        : repository.compressImage(path);
  }
}
