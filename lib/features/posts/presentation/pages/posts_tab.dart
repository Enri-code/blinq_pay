import 'package:blinq_pay/core/utils/extensions/data_state.dart';
import 'package:blinq_pay/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:blinq_pay/features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';
import 'package:blinq_pay/features/posts/presentation/widgets/post_widget.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:blinq_pay/features/users/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:blinq_pay/features/users/presentation/widgets/user_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PostsTab extends StatefulWidget {
  const PostsTab({super.key});

  @override
  State<PostsTab> createState() => _PostsTabState();
}

class _PostsTabState extends State<PostsTab> {
  @override
  void initState() {
    if (context.read<PostsBloc>().state is! FoundPostsState) {
      context.read<PostsBloc>().add(GetPostsEvent());
    }
    if (context.read<UsersBloc>().state is! FoundUsersState) {
      context.read<UsersBloc>().add(GetUsersEvent());
    }
    super.initState();
  }

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
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
                child: SizedBox(
                  height: 80.h,
                  child: BlocBuilder<UsersBloc, UsersState>(
                    builder: (context, state) {
                      if (state is FoundUsersState) {
                        return ListView.separated(
                          itemCount: 7,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 6.h),
                          itemBuilder: (context, index) {
                            final user = state.data.data[index];
                            return UserStatusWidget(user: user);
                          },
                          separatorBuilder: (context, index) {
                            return 12.horizontalSpace;
                          },
                        );
                      }
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: ListView.separated(
                          itemCount: 7,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 6.h),
                          itemBuilder: (context, index) {
                            final user = User(
                              userId: '',
                              username: 'username',
                              name: 'User',
                              bio: '',
                              photo: '',
                            );
                            return UserStatusWidget(user: user);
                          },
                          separatorBuilder: (context, index) {
                            return 12.horizontalSpace;
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state.dataState?.isError == true && false) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      state.dataState?.error?.message ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                );
              }
              if (state is NoPostsState && false) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      'No posts found',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                );
              }

              if (state is FoundPostsState) {
                return SliverList.separated(
                  itemCount: state.data.data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.data.data.length) {
                      return const SizedBox(
                        height: 100,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final post = state.data.data[index];
                    return PostWidget(key: ValueKey(post.id), post: post);
                  },
                  separatorBuilder: (context, index) => 32.verticalSpace,
                );
              }
              return SliverToBoxAdapter(
                child: IgnorePointer(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final post = Post(
                          id: 'id-$index',
                          userId: '',
                          description: '',
                          username: '',
                          // thumbnail: index % 2 == 0
                          //     ? 'https://cdn.dribbble.com/users/14790058/avatars/normal/2283a992ab80bcd500f7b950ba865cf1.jpg?1699074419'
                          //     : 'https://cdn.dribbble.com/userupload/8282521/file/original-26d484aaa28576dafce6b1f7dc0b2bf7.png?resize=752x&vertical=center',
                          // link: index % 2 == 0
                          //     ? 'https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_30mb.mp4'
                          //     : 'https://cdn.dribbble.com/userupload/8282521/file/original-26d484aaa28576dafce6b1f7dc0b2bf7.png?resize=752x&vertical=center',
                          timestamp: DateTime.now(),
                          noMedia: false,
                          video: false,
                          user: User(
                            userId: '',
                            username: 'username',
                            name: 'User',
                            bio: '',
                            photo: '',
                          ),
                        );
                        return PostWidget(key: ValueKey(post.id), post: post);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
