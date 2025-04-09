import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final darkTheme = ThemeData.dark().copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  shadowColor: Colors.black.withAlpha(60),
  scaffoldBackgroundColor: Colors.black,
  primaryColorLight: const Color(0xFFEB7E3D),
  primaryColorDark: const Color(0xFF7E41D6),
  primaryColor: Colors.white,
  tabBarTheme: const TabBarTheme(labelColor: Color(0xFFEB7E3D)),
  // scaffoldBackgroundColor: Color(0xFF121212),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: ThemeData.dark().cardColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: ThemeData.dark().dividerColor),
    ),
    contentPadding: EdgeInsets.all(12),
  ),
);
