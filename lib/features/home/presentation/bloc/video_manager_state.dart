part of 'video_manager_bloc.dart';

sealed class VideoManagerState {}

final class VideoManagerNoController extends VideoManagerState {}

final class VideoManagerWithController extends VideoManagerState {
  final VideoPlayerController? controller;

  VideoManagerWithController({
    required this.controller,
  });
}
