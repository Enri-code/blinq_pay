import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:blinq_pay/core/constants/generated_image.dart';
import 'package:blinq_pay/core/theme/app_theme.dart';
import 'package:blinq_pay/core/utils/extensions/theme.dart';
import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:blinq_pay/features/posts/presentation/widgets/post_widget.dart';
import 'package:blinq_pay/features/users/presentation/widgets/user_status.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:light_dark_theme_toggle/light_dark_theme_toggle.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

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
          SliverAppBar(
            toolbarHeight: 48.h,
            leadingWidth: 140.w,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).splashColor, width: 2),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            leading: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: SvgPicture.asset(
                context.isDarkMode
                    ? ImageAssets.blinqpayDark
                    : ImageAssets.blinqpayLight,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_to_photos_outlined),
                onPressed: () {},
              ),
              ThemeSwitcher.withTheme(builder: (context, switcher, theme) {
                return LightDarkThemeToggle(
                  // Initial value (false for dark, true for light)
                  size: 24,
                  curve: Curves.easeInOut,
                  value: context.isDarkMode,
                  themeIconType: ThemeIconType.expand,
                  color: Theme.of(context).appBarTheme.foregroundColor,
                  onChanged: (bool value) {
                    switcher.changeTheme(
                      theme: value ? AppTheme.dark : AppTheme.light,
                    );
                  },
                );
              }),
              16.horizontalSpace,
            ],
            bottom: PreferredSize(
              preferredSize: Size(1.sw, 92.h),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                child: SizedBox(
                  height: 78.h,
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
                          photo: 'https://cdn.dribbble.com/users/14790058/avatars/normal/2283a992ab80bcd500f7b950ba865cf1.jpg?1699074419',
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => 16.horizontalSpace,
                  ),
                ),
              ),
            ),
            flexibleSpace: MeshGradient(
              points: [
                MeshGradientPoint(
                  position: const Offset(0, 0),
                  color: Color.lerp(Theme.of(context).primaryColorDark,
                      Theme.of(context).scaffoldBackgroundColor, .4)!,
                ),
                MeshGradientPoint(
                  position: const Offset(1, 0),
                  color: Color.lerp(Theme.of(context).primaryColor,
                      Theme.of(context).scaffoldBackgroundColor, .4)!,
                ),
                MeshGradientPoint(
                  position: const Offset(0, 1),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                MeshGradientPoint(
                  position: const Offset(0.5, 1),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                MeshGradientPoint(
                  position: const Offset(1, 1),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ],
              options: MeshGradientOptions(blend: 4, noiseIntensity: 0),
              child: SizedBox.expand(),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                final post = Post(
                  id: 'id-$index',
                  userId: 'userId',
                  description:
                      // "Lorem Ipsum is simply dummy text of the printing and typesetting"
                      // " industry. Lorem Ipsum has been the industry's standard dummy text"
                      // " ever since the 1500s, when an unknown printer took a galley of "
                      // "type and scrambled it to make a type specimen book. It has survived"
                      // " not only five centuries, but also the leap into electronic "
                      // "typesetting, remaining essentially unchanged. It was popularised in"
                      // " the 1960s with the release of Letraset sheets containing Lorem "
                      // "Ipsum passages, and more recently with desktop publishing software "
                      "like Aldus PageMaker including versions of Lorem Ipsum.",
                  username: 'username',
                  thumbnail: index % 2 == 0 || true
                      ? 'https://cdn.dribbble.com/users/14790058/avatars/normal/2283a992ab80bcd500f7b950ba865cf1.jpg?1699074419'
                      : 'https://cdn.dribbble.com/userupload/8282521/file/original-26d484aaa28576dafce6b1f7dc0b2bf7.png?resize=752x&vertical=center',
                  link: index % 2 == 0 || true
                      ? 'https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_30mb.mp4'
                      : 'https://cdn.dribbble.com/userupload/8282521/file/original-26d484aaa28576dafce6b1f7dc0b2bf7.png?resize=752x&vertical=center',
                  timestamp:
                      DateTime.now().subtract(Duration(minutes: index * index)),
                  noMedia: index % 3 == 2 && false,
                  video: index % 2 == 0 || true,
                  user: User(
                    userId: 'userId',
                    username: 'username',
                    name: 'Full Name',
                    bio: 'bio',
                    photo: 'https://cdn.dribbble.com/users/14790058/avatars/normal/2283a992ab80bcd500f7b950ba865cf1.jpg?1699074419',
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
