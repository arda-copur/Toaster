import 'package:toaster/data/repositories/media_repository.dart';

import '../../data/models/media_model.dart';

abstract class MediaEvent {}

class PickMedia extends MediaEvent {
  final bool isVideo;
  final MediaRepository repository;

  PickMedia(this.isVideo, this.repository);
}

class CompressMedia extends MediaEvent {
  final MediaModel media;

  CompressMedia(this.media);
}

class DownloadMedia extends MediaEvent {
  final String mediaPath;

  DownloadMedia(this.mediaPath);
}
