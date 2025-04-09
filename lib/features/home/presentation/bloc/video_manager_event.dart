part of 'video_manager_bloc.dart';

sealed class VideoManagerEvent {}

class SetVideoControllerEvent extends VideoManagerEvent {
  final VideoPlayerController controller;

  SetVideoControllerEvent({required this.controller});
}

class RemoveVideoControllerEvent extends VideoManagerEvent {
  final VideoPlayerController? controller;
  RemoveVideoControllerEvent({this.controller});
}

class PauseVideoControllerEvent extends VideoManagerEvent {
  PauseVideoControllerEvent();
}
