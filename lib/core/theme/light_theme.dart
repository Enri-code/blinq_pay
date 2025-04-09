import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final lightTheme = ThemeData.light().copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  shadowColor: Colors.black.withAlpha(60),
  scaffoldBackgroundColor: Colors.white,
  primaryColorLight: const Color(0xFFEB7E3D),
  primaryColorDark: const Color(0xFF7E41D6),
  primaryColor: Colors.black,
  tabBarTheme: const TabBarTheme(labelColor: Color(0xFFEB7E3D)),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: ThemeData.light().cardColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: ThemeData.light().dividerColor),
    ),
    contentPadding: EdgeInsets.all(12),
  ),
);
