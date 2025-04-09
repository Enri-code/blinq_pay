import 'dart:math';

import 'package:blinq_pay/core/utils/helper_functions.dart';
import 'package:blinq_pay/features/home/presentation/pages/photo_view_page.dart';
import 'package:blinq_pay/features/home/presentation/widgets/video_player_widget.dart';
import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:blinq_pay/features/users/presentation/widgets/user_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bounce/bounce.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PostHeader(post: post),
        if (post.description.isNotEmpty) ...[
          4.verticalSpace,
          Text(
            post.description,
            style: Theme.of(context).textTheme.bodyMedium,
            // textAlign: TextAlign.justify,
          ),
        ],
        if (!post.noMedia) ...[
          4.verticalSpace,
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Bounce(
              scaleFactor: .98,
              tiltAngle: pi / 20,
              duration: Durations.short4,
              child: Card(
                elevation: 4,
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Hero(tag: post.link!, child: _PostContent(post: post)),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _PostContent extends StatelessWidget {
  const _PostContent({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (post.video) {
        return GestureDetector(
          onTap: () {
            // Navigator.of(context).push(pageRouteWrapper(
            //   VideoPlayerPage(
            //     videoUrl: post.link!,
            //     thumbnail: post.thumbnail!,
            //   ),
            // ));
          },
          child: VideoPlayerWidget(
            videoUrl: post.link!,
            thumbnail: post.thumbnail!,
          ),
        );
      } else {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(pageRouteWrapper(
              PhotoViewPage(url: post.link!),
            ));
          },
          child: Image.network(
            fit: BoxFit.cover,
            post.thumbnail!,
          ),
        );
      }
    });
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserProfileWidget(user: post.user),
        8.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    post.user.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Spacer(),
                  Text(
                    timeago.format(post.timestamp),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Text(
                post.username,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
