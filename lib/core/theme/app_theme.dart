import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

class AppTheme {
  static ThemeData light = lightTheme;
  static ThemeData dark = darkTheme;
}

extension MytTHemeExt on TextStyle {
  TextStyle get sp => copyWith(fontSize: fontSize?.sp);
}
