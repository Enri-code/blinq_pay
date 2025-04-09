import 'package:blinq_pay/features/home/presentation/bloc/video_manager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    required this.thumbnail,
  });

  final String videoUrl, thumbnail;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final VideoPlayerController _controller;
  late final VideoManagerBloc videoManagerBloc;
  VisibilityInfo? _info;

  @override
  void initState() {
    super.initState();
    videoManagerBloc = context.read<VideoManagerBloc>();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize()
      ..addListener(() {
        if (_controller.value.isBuffering || _controller.value.isInitialized) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Image.network(widget.thumbnail, fit: BoxFit.cover);
    }
    return VisibilityDetector(
      key: ValueKey(widget.videoUrl),
      onVisibilityChanged: (info) {
        _info = info;
        if (info.visibleFraction == 1) {
          _controller
            ..play()
            ..setLooping(true);
          videoManagerBloc
            ..add(PauseVideoControllerEvent())
            ..add(SetVideoControllerEvent(controller: _controller));
        } else {
          _controller
            ..pause()
            ..setLooping(false);
          if (mounted) {
            videoManagerBloc.add(
              RemoveVideoControllerEvent(controller: _controller),
            );
          }
        }
      },
      child: BlocListener<VideoManagerBloc, VideoManagerState>(
        listenWhen: (p, c) => c is VideoManagerNoController && _info != null,
        listener: (context, state) {
          if (_info!.visibleFraction == 1) {
            _controller
              ..play()
              ..setLooping(true);
            context
                .read<VideoManagerBloc>()
                .add(SetVideoControllerEvent(controller: _controller));
          }
        },
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: 1.sw,
            height: (1 / _controller.value.aspectRatio).sw,
            child: VideoPlayer(_controller),
          ),
        ),
      ),
    );
  }
}
