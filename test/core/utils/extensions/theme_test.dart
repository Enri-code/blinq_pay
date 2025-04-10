import 'package:blinq_pay/core/utils/extensions/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyThemeExt - isDarkMode and isLightMode',
      (WidgetTester tester) async {
    // Test for Light Mode
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        home: Builder(
          builder: (context) {
            expect(context.isLightMode, true);
            expect(context.isDarkMode, false);
            return Container();
          },
        ),
      ),
    );

    // Test for Dark Mode
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Builder(
          builder: (context) {
            expect(context.isLightMode, false);
            expect(context.isDarkMode, true);
            return Container();
          },
        ),
      ),
    );
  });
}
