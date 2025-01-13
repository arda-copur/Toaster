import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toaster/l10n/app_localizations.dart';
import '../bloc/media_bloc.dart';
import '../bloc/media_event.dart';
import '../bloc/media_state.dart';
import '../../data/repositories/media_repository.dart';
import '../../data/data_sources/image_data_source.dart';
import '../../data/data_sources/video_data_source.dart';
import 'dart:io';

class MediaScreen extends StatelessWidget {
  const MediaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaRepository = MediaRepository(
      imageDataSource: ImageDataSource(),
      videoDataSource: VideoDataSource(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle),
      ),
      body: BlocBuilder<MediaBloc, MediaState>(
        builder: (context, state) {
          return _buildBody(context, state);
        },
      ),
      floatingActionButton:
          _buildFloatingActionButtons(context, mediaRepository),
    );
  }

  Widget _buildBody(BuildContext context, MediaState state) {
    if (state is MediaInitial) {
      return Center(
        child: Text(AppLocalizations.of(context).noMediaSelected,
            style: Theme.of(context).textTheme.bodyMedium),
      );
    } else if (state is MediaPicked) {
      return _buildMediaPickedView(state, context);
    } else if (state is MediaCompressed) {
      return _buildMediaCompressedView(state, context);
    } else if (state is MediaDownloaded) {
      return _buildMediaDownloadedView(state, context);
    }
    return const SizedBox();
  }

  Widget _buildMediaPickedView(MediaPicked state, context) {
    final file = File(state.media.path);
    final originalSize = file.lengthSync();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context).mediaPath(state.media.path),
            style: Theme.of(context).textTheme.bodyMedium),
        Text(
          AppLocalizations.of(context).originalSize(originalSize.toString()),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        ElevatedButton(
          onPressed: () {
            context.read<MediaBloc>().add(CompressMedia(state.media));
          },
          child: Text(AppLocalizations.of(context).compressMedia),
        ),
      ],
    );
  }

  Widget _buildMediaCompressedView(MediaCompressed state, context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context).compressedMedia,
            style: Theme.of(context).textTheme.bodyMedium),
        ...state.compressedPaths.map((path) {
          final compressedFile = File(path);
          final compressedSize = compressedFile.lengthSync();
          return Column(
            children: [
              Image.file(compressedFile, width: 100, height: 100),
              Text('Path: $path', style: Theme.of(context).textTheme.bodySmall),
              Text('Size: ${compressedSize / 1024} KB',
                  style: Theme.of(context).textTheme.bodySmall),
              ElevatedButton(
                onPressed: () {
                  context.read<MediaBloc>().add(DownloadMedia(path));
                },
                child: Text(AppLocalizations.of(context).downloadMedia),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildMediaDownloadedView(MediaDownloaded state, context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context).downloadedMediaPath(state.filePath),
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildFloatingActionButtons(
      BuildContext context, MediaRepository mediaRepository) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            context.read<MediaBloc>().add(PickMedia(false, mediaRepository));
          },
          tooltip: AppLocalizations.of(context).pickImage,
          child: const Icon(Icons.add_a_photo),
        ),
        const SizedBox(width: 10),
        FloatingActionButton(
          onPressed: () {
            context.read<MediaBloc>().add(PickMedia(true, mediaRepository));
          },
          tooltip: AppLocalizations.of(context).pickVideo,
          child: const Icon(Icons.video_library),
        ),
      ],
    );
  }
}
