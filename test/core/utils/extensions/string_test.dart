import 'package:blinq_pay/core/utils/extensions/string.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('String Extension', () {
    group('firstName getter', () {
      test('firstName returns first name when string has multiple words', () {
        final name = 'John Doe';
        expect(name.firstName, 'John');
      });

      test('firstName returns name when string has one word', () {
        final name = 'John';
        expect(name.firstName, 'John');
      });

      test('firstName returns empty string when string is empty', () {
        final name = '';
        expect(name.firstName, '');
      });
    });

    group('initials getter', () {
      test('initials returns correct initials for a two-word name', () {
        final name = 'John Doe';
        expect(name.initials, 'JD');
      });

      test('initials returns first letter for a single-word name', () {
        final name = 'John';
        expect(name.initials, 'J');
      });

      test('initials returns empty string when name is empty', () {
        final name = '';
        expect(name.initials, '');
      });
    });
  });
}
