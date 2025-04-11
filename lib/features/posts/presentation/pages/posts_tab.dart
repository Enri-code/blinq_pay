import 'package:blinq_pay/core/theme/app_theme.dart';
import 'package:blinq_pay/core/utils/extensions/data_state.dart';
import 'package:blinq_pay/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:blinq_pay/features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';
import 'package:blinq_pay/features/posts/presentation/widgets/post_widget.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:blinq_pay/features/users/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:blinq_pay/features/users/presentation/widgets/user_status.dart';
import 'package:flutter/cupertino.dart';
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
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          return CustomScrollView(
            cacheExtent: 1000,
            physics: state is PostsInitialState
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            slivers: [const _AppBarWidget(), const _ScrollBodyWidget()],
          );
        },
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
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
                      final user = state.data.data.take(15).toList()[index];
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
    );
  }
}

class _ScrollBodyWidget extends StatelessWidget {
  const _ScrollBodyWidget();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state.dataState.isError) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  state.dataState.error?.message ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.sp,
                ),
              ),
            );
          }
          if (state is NoPostsState) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  'No posts found',
                  style: Theme.of(context).textTheme.bodyLarge?.sp,
                ),
              ),
            );
          }
          if (state is FoundPostsState) {
            return SliverList.builder(
              itemCount: state.data.data.length + 1,
              itemBuilder: (context, index) {
                if (index == state.data.data.length) {
                  context.read<PostsBloc>().add(GetMorePostsEvent());
                  return SizedBox(
                    height: 120,
                    child: Align(
                      alignment: Alignment(0, -.75),
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                }
                final post = state.data.data[index];
                return Padding(
                  padding: EdgeInsets.only(top: 32.h),
                  child: PostWidget(key: ValueKey(post.id), post: post),
                );
              },
            );
          }
          return SliverFillRemaining(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final post = Post(
                    id: 'id-$index',
                    userId: '',
                    description: '',
                    username: '',
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
                  return Padding(
                    padding: EdgeInsets.only(bottom: 32.h),
                    child: PostWidget(key: ValueKey(post.id), post: post),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
