part of 'video_manager_bloc.dart';

sealed class VideoManagerState {
  VideoPlayerController? get getController {
    return this is VideoManagerWithController
        ? (this as VideoManagerWithController).controller
        : null;
  }
}

final class VideoManagerNoController extends VideoManagerState {}

final class VideoManagerWithController extends VideoManagerState {
  final VideoPlayerController? controller;

  VideoManagerWithController({
    required this.controller,
  });
}
