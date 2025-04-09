import 'dart:math';

import 'package:blinq_pay/features/home/presentation/widgets/app_bar.dart';
import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:blinq_pay/features/posts/presentation/widgets/post_widget.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:blinq_pay/features/users/presentation/widgets/user_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostsTab extends StatefulWidget {
  const PostsTab({super.key});

  @override
  State<PostsTab> createState() => _PostsTabState();
}

class _PostsTabState extends State<PostsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        cacheExtent: 1000,
        physics: const BouncingScrollPhysics(),
        slivers: [
          CustomAppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.add_to_photos_outlined),
                color: Theme.of(context).appBarTheme.foregroundColor,
                onPressed: () {},
              ),
              ThemeSwitch(),
            ],
            bottom: PreferredSize(
              preferredSize: Size(1.sw, 86.h),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(32)),
                child: SizedBox(
                  height: 80.h,
                  child: ListView.separated(
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 6.h),
                    itemBuilder: (context, index) {
                      return UserStatusWidget(
                        user: User(
                          userId: 'userId',
                          username: 'username',
                          name: 'Full Name',
                          bio: 'bio',
                          photo:
                              'https://cdn.dribbble.com/users/14790058/avatars/normal/2283a992ab80bcd500f7b950ba865cf1.jpg?1699074419',
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => 12.horizontalSpace,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                final post = Post(
                  id: 'id-$index',
                  userId: 'userId',
                  description: "Lorem Ipsum is simply dummy text of the printing and typesetting"
                          " industry. Lorem Ipsum has been the industry's standard dummy text"
                          " ever since the 1500s, when an unknown printer took a galley of "
                          "type and scrambled it to make a type specimen book. It has survived"
                          " not only five centuries, but also the leap into electronic "
                          "typesetting, remaining essentially unchanged. It was popularised in"
                          " the 1960s with the release of Letraset sheets containing Lorem "
                          "Ipsum passages, and more recently with desktop publishing software "
                          "like Aldus PageMaker including versions of Lorem Ipsum."
                      .substring(Random().nextInt(500)),
                  username: 'username',
                  thumbnail: index % 2 == 0
                      ? 'https://cdn.dribbble.com/users/14790058/avatars/normal/2283a992ab80bcd500f7b950ba865cf1.jpg?1699074419'
                      : 'https://cdn.dribbble.com/userupload/8282521/file/original-26d484aaa28576dafce6b1f7dc0b2bf7.png?resize=752x&vertical=center',
                  link: index % 2 == 0
                      ? 'https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_30mb.mp4'
                      : 'https://cdn.dribbble.com/userupload/8282521/file/original-26d484aaa28576dafce6b1f7dc0b2bf7.png?resize=752x&vertical=center',
                  timestamp:
                      DateTime.now().subtract(Duration(minutes: index * index)),
                  noMedia: index % 3 == 2,
                  video: index % 2 == 0,
                  user: User(
                    userId: 'userId',
                    username: 'username',
                    name: 'Full Name',
                    bio: 'bio',
                    photo:
                        'https://cdn.dribbble.com/users/14790058/avatars/normal/2283a992ab80bcd500f7b950ba865cf1.jpg?1699074419',
                  ),
                );
                return PostWidget(key: ValueKey(post.id), post: post);
              },
              separatorBuilder: (context, index) => 24.verticalSpace,
            ),
          ),
        ],
      ),
    );
  }
}
