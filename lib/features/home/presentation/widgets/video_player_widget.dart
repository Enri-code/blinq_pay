import 'package:better_player/better_player.dart';
import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.post});
  final Post post;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final BetterPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BetterPlayerController(
      BetterPlayerConfiguration(
        looping: true,
        autoPlay: true,
        aspectRatio: 1,
        fit: BoxFit.cover,
        // showPlaceholderUntilPlay: true,
        placeholder: CachedNetworkImage(
          imageUrl: widget.post.thumbnail,
          fit: BoxFit.cover,
          errorWidget: (context, error, stackTrace) => SizedBox(),
        ),
        deviceOrientationsOnFullScreen: DeviceOrientation.values,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableOverflowMenu: false,
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource.network(
        widget.post.link,
        cacheConfiguration: BetterPlayerCacheConfiguration(
          useCache: true,
          // key: widget.post.link!,
        ),
        notificationConfiguration: BetterPlayerNotificationConfiguration(
          showNotification: true,
          title: widget.post.description,
          author: widget.post.user.username,
          imageUrl: widget.post.thumbnail,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(controller: _controller);
  }
}
