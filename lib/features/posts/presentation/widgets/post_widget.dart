import 'dart:math';

import 'package:blinq_pay/core/utils/helper_functions.dart';
import 'package:blinq_pay/features/home/presentation/pages/photo_view_page.dart';
import 'package:blinq_pay/features/home/presentation/widgets/video_player_widget.dart';
import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:blinq_pay/features/users/presentation/widgets/user_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          6.verticalSpace,
          Text(
            post.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
        if (!post.noMedia) ...[
          6.verticalSpace,
          AspectRatio(
            aspectRatio: 1,
            child: Bounce(
              scaleFactor: .98,
              tiltAngle: pi / 20,
              duration: Durations.short4,
              child: Card(
                elevation: 4,
                clipBehavior: Clip.hardEdge,
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).dividerColor,
                    // width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Hero(tag: post.id, child: _PostContent(post: post)),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserProfileWidget(user: post.user, radius: 20.r),
        8.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    post.user.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Spacer(),
                  Text(
                    timeago.format(post.timestamp),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Text(
                '@${post.username}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
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
        return VideoPlayerWidget(post: post);
      } else {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(pageRouteWrapper(
              PhotoViewPage(url: post.link, tag: post.id),
            ));
          },
          child: CachedNetworkImage(
            imageUrl: post.thumbnail,
            fit: BoxFit.cover,
            errorWidget: (context, error, stackTrace) => SizedBox(),
            // frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            //   return ColoredBox(color: Theme.of(context).primaryColor);
            // },
          ),
        );
      }
    });
  }
}
