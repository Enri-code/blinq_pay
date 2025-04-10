import 'package:flutter/material.dart';

extension MyThemeExt on BuildContext {
  /// Returns the current brightness of the app.
  Brightness get brightness => Theme.of(this).brightness;

  /// Returns true if the current theme is dark.
  bool get isDarkMode => brightness == Brightness.dark;

  /// Returns true if the current theme is light.
  bool get isLightMode => brightness == Brightness.light;
}