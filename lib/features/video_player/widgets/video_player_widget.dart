import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:blinq_pay/features/video_player/bloc/video_manager_bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.post});
  final Post post;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final VideoPlayerController videoPlayerController;
  late final ChewieController chewieController;

  late final VideoManagerBloc videoManagerBloc;
  VisibilityInfo? _info;

  @override
  void initState() {
    super.initState();
    videoManagerBloc = context.read<VideoManagerBloc>();
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.post.link),
    );

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 1,
      autoPlay: true,
      autoInitialize: true,
      looping: true,
      showOptions: false,
      playbackSpeeds: const [0.25, 0.5, 1, 1.5, 2, 3],
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(widget.post),
      onVisibilityChanged: _onVisibilityChanged,
      child: BlocListener<VideoManagerBloc, VideoManagerState>(
        listenWhen: (p, c) {
          return _info != null && c is VideoManagerNoController;
        },
        listener: (context, state) {
          if (_info!.visibleFraction == 1) _play();
        },
        // child: FittedBox(
        //   fit: BoxFit.cover,
        //   child: SizedBox(
        //     width: 1.sw,
        //     height: (1 / videoPlayerController.value.aspectRatio).sw,
        child: Chewie(controller: chewieController),
        // ),
        // ),
      ),
    );
  }

  void _onVisibilityChanged(VisibilityInfo info) async {
    if (info.visibleFraction == 1) {
      if (videoManagerBloc.state.getController != videoPlayerController) {
        videoManagerBloc.add(PauseVideoControllerEvent());
      }
      _play();
    } else if (videoManagerBloc.state.getController == videoPlayerController) {
      _pause();
    }
    _info = info;
  }

  void _pause() {
    videoManagerBloc
      ..add(PauseVideoControllerEvent())
      ..add(RemoveVideoControllerEvent());
  }

  void _play() {
    videoManagerBloc
      ..add(SetVideoControllerEvent(controller: videoPlayerController))
      ..add(PlayVideoControllerEvent());
  }
}
