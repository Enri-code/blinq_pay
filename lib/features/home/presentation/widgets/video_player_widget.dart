import 'package:blinq_pay/features/home/presentation/bloc/video_manager_bloc.dart';
import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.post});
  final Post post;

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
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.post.link!))
      ..initialize().then((value) => setState(() {}))
      ..setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        if (!_controller.value.isInitialized)
          CachedNetworkImage(
            imageUrl: widget.post.thumbnail!,
            fit: BoxFit.cover,
            errorWidget: (context, error, stackTrace) => SizedBox(),
          )
        else
          VisibilityDetector(
            key: ValueKey(widget.post),
            onVisibilityChanged: _onVisibilityChanged,
            child: BlocListener<VideoManagerBloc, VideoManagerState>(
              listenWhen: (p, c) {
                return _info != null && c is VideoManagerNoController;
              },
              listener: (context, state) {
                if (_info!.visibleFraction == 1) _play();
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
          ),
        Center(
          child: IconTheme(
            data: Theme.of(context).iconTheme.copyWith(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  size: 90.sp,
                ),
            child: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (context, _, __) {
                if (_controller.value.hasError) {
                  return Icon(Icons.videocam_off_outlined);
                }
                if (_controller.value.isBuffering ||
                    !_controller.value.isInitialized) {
                  return CircularProgressIndicator(color: Colors.white);
                }
                if (!_controller.value.isPlaying) {
                  return Icon(Icons.play_arrow_rounded);
                }
                return SizedBox();
              },
            ),
          ),
        ),
      ],
    );
  }

  void _onVisibilityChanged(VisibilityInfo info) async {
    if (info.visibleFraction == 1) {
      if (videoManagerBloc.state.getController != _controller) {
        videoManagerBloc.add(PauseVideoControllerEvent());
      }
      _play();
    } else if (videoManagerBloc.state.getController == _controller) {
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
      ..add(SetVideoControllerEvent(controller: _controller))
      ..add(PlayVideoControllerEvent());
  }
}
