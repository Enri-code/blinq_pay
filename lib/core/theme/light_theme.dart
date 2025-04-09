import 'package:flutter/material.dart';

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
  tabBarTheme: const TabBarTheme(labelColor: Color(0xFF7E41D6)),
);
