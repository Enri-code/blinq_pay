import 'package:blinq_pay/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:blinq_pay/features/users/presentation/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        cacheExtent: 1000,
        physics: const BouncingScrollPhysics(),
        slivers: [
          CustomAppBar(
            actions: [ThemeSwitch()],
            bottom: PreferredSize(
              preferredSize: Size(1.sw, 86.h),
              child: SizedBox(
                height: 82.h,
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                final user = User(
                  userId: 'userId',
                  username: 'username',
                  name: 'Full Name',
                  bio: 'bio',
                  photo:
                      'https://cdn.dribbble.com/users/14790058/avatars/normal/2283a992ab80bcd500f7b950ba865cf1.jpg?1699074419',
                );
                return UserTileWidget(user: user);
              },
              separatorBuilder: (context, index) => 16.verticalSpace,
            ),
          ),
        ],
      ),
    );
  }
}
