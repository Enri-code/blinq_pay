import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:blinq_pay/core/constants/generated_image.dart';
import 'package:blinq_pay/core/theme/app_theme.dart';
import 'package:blinq_pay/core/utils/extensions/theme.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:light_dark_theme_toggle/light_dark_theme_toggle.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.bottom, this.actions});
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      toolbarHeight: 48.h,
      leadingWidth: 136.w,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).splashColor, width: 2),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      leading: _LogoHeaderWidget(),
      flexibleSpace: _AppBarGradientWidget(),
      actions: [...?actions, 16.horizontalSpace],
      bottom: bottom,
    );
  }
}

class _AppBarGradientWidget extends StatelessWidget {
  const _AppBarGradientWidget();

  @override
  Widget build(BuildContext context) {
    return MeshGradient(
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
    );
  }
}

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher.withTheme(builder: (context, switcher, theme) {
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
    });
  }
}

class _LogoHeaderWidget extends StatelessWidget {
  const _LogoHeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Bounce(
        child: SvgPicture.asset(
          context.isDarkMode
              ? ImageAssets.blinqpayDark
              : ImageAssets.blinqpayLight,
        ),
      ),
    );
  }
}
