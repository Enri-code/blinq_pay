import 'package:flutter/material.dart';

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
  tabBarTheme: const TabBarTheme(labelColor: Colors.white),
  // scaffoldBackgroundColor: Color(0xFF121212),
);
