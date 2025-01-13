import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/compress_media_usecase.dart';
import '../../domain/download_media_usecase.dart';
import 'media_event.dart';
import 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final CompressMediaUseCase compressMediaUseCase;
  final DownloadMediaUseCase downloadMediaUseCase;

  MediaBloc(this.compressMediaUseCase, this.downloadMediaUseCase)
      : super(MediaInitial()) {
    on<PickMedia>((event, emit) async {
      if (event.isVideo) {
        final media = await event.repository.pickVideo();
        if (media != null) {
          emit(MediaPicked(media));
        }
      } else {
        final media = await event.repository.pickImage();
        if (media != null) {
          emit(MediaPicked(media));
        }
      }
    });

    on<CompressMedia>((event, emit) async {
      final compressedPaths = await compressMediaUseCase.execute(
          event.media.path, event.media.isVideo);
      emit(MediaCompressed(compressedPaths as List<String>));
    });

    on<DownloadMedia>((event, emit) async {
      final filePath = await downloadMediaUseCase.execute(event.mediaPath);
      emit(MediaDownloaded(filePath));
    });
  }
}