import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark().copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.black,
  primaryColorLight: const Color(0xFFEB7E3D),
  primaryColorDark: const Color(0xFF7E41D6),
  // scaffoldBackgroundColor: Color(0xFF121212),
);
