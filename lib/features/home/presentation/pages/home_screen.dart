import 'package:blinq_pay/core/constants/generated_image.dart';
import 'package:blinq_pay/features/posts/presentation/pages/posts_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myPrecacheImage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        // bottomScreenMargin: 0,
        navBarStyle: NavBarStyle.style13,
        navBarHeight: 48,
        stateManagement: false,
        handleAndroidBackButtonPress: false,

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        margin: EdgeInsets.symmetric(horizontal: .2.sw, vertical: 20),
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(16),
          // colorBehindNavBar: Theme.of(context).scaffoldBackgroundColor,
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
        screens: [PostsTab(), PostsTab()],
      ),
    );
  }
}
