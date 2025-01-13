import '../../data/models/media_model.dart';

abstract class MediaState {}

class MediaInitial extends MediaState {}

class MediaPicked extends MediaState {
  final MediaModel media;

  MediaPicked(this.media);
}

class MediaCompressed extends MediaState {
  final List<String> compressedPaths;

  MediaCompressed(this.compressedPaths);
}

class MediaDownloaded extends MediaState {
  final String filePath;

  MediaDownloaded(this.filePath);
}
