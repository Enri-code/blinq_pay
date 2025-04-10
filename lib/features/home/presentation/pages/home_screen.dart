import 'package:blinq_pay/features/posts/presentation/pages/posts_tab.dart';
import 'package:blinq_pay/features/users/presentation/pages/users_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        navBarStyle: NavBarStyle.style13,
        navBarHeight: 48,
        stateManagement: false,
        handleAndroidBackButtonPress: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        margin: EdgeInsets.symmetric(horizontal: .2.sw, vertical: 20),
        decoration: NavBarDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Theme.of(context).shadowColor,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        items: [
          PersistentBottomNavBarItem(
            activeColorPrimary: Theme.of(context).tabBarTheme.labelColor!,
            icon: Icon(Icons.comment_bank_outlined),
            title: 'Posts',
          ),
          PersistentBottomNavBarItem(
            activeColorPrimary: Theme.of(context).tabBarTheme.labelColor!,
            icon: Icon(Icons.groups),
            title: 'Users',
          ),
        ],
        screens: [PostsTab(), UsersTab()],
      ),
    );
  }
}
