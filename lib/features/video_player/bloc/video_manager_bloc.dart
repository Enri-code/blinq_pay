import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

part 'video_manager_event.dart';
part 'video_manager_state.dart';

class VideoManagerBloc extends Bloc<VideoManagerEvent, VideoManagerState> {
  VideoManagerBloc() : super(VideoManagerNoController()) {
    on<SetVideoControllerEvent>((event, emit) {
      emit(VideoManagerWithController(controller: event.controller));
    });
    on<RemoveVideoControllerEvent>((event, emit) {
      if (state is VideoManagerWithController) {
        emit(VideoManagerNoController());
      }
    });
    on<PauseVideoControllerEvent>((event, emit) {
      state.getController?.pause();
    });
    on<PlayVideoControllerEvent>((event, emit) {
      state.getController?.play();
    });
  }
}
