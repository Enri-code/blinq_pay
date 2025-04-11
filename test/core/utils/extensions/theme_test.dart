import 'package:blinq_pay/core/utils/extensions/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyThemeExt - isDarkMode and isLightMode', () {
    testWidgets('isDarkMode', (WidgetTester tester) async {
      // Test for Dark Mode
      await tester.pumpWidget(
        MaterialApp(theme: ThemeData.dark(), home: Scaffold()),
      );

      final context = tester.element(find.byType(Scaffold));
      expect(context.isDarkMode, true);
      expect(context.isLightMode, false);
    });
    testWidgets('isLightMode', (WidgetTester tester) async {
      // Test for Light Mode
      await tester.pumpWidget(
        MaterialApp(theme: ThemeData.light(), home: Scaffold()),
      );

      final context = tester.element(find.byType(Scaffold));
      expect(context.isLightMode, true);
      expect(context.isDarkMode, false);
    });
  });
}
