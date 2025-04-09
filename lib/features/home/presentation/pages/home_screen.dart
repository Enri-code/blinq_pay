import 'package:blinq_pay/core/constants/generated_image.dart';
import 'package:blinq_pay/features/posts/presentation/pages/posts_tab.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myPrecacheImage(context);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [PostsTab(), PostsTab()],
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: pageController,
        builder: (context, child) {
          return FloatingNavbar(
            // unselectedItemColor: Theme.of(context).disabledColor,
            // selectedItemColor: Theme.of(context).primaryColor,
            width: 1.sw,
            margin: EdgeInsets.zero,
            currentIndex:
                pageController.hasClients ? pageController.page?.round() : 0,
            onTap: (index) {
              pageController.animateToPage(
                index,
                duration: Durations.medium2,
                curve: Curves.easeOut,
              );
            },
            items: [
              FloatingNavbarItem(
                title: 'Home',
                icon: Icons.comment_bank_outlined,
              ),
              FloatingNavbarItem(
                title: 'Users',
                icon: Icons.groups,
              ),
            ],
          );
        },
      ),
    );
  }
}
