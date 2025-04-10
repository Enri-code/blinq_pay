import 'package:blinq_pay/core/utils/extensions/data_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:blinq_pay/core/utils/data_helpers.dart';

void main() {
  group('DataState Extension', () {
    test('isLoading returns true when status is loading', () {
      final state = DataState(status: Status.loading);
      expect(state.isLoading, true);
      expect(state.isSuccess, false);
      expect(state.isError, false);
    });

    test('isSuccess returns true when status is success', () {
      final state = DataState(status: Status.success);
      expect(state.isSuccess, true);
      expect(state.isLoading, false);
      expect(state.isError, false);
    });

    test('isError returns true when status is error', () {
      final state = DataState(status: Status.error);
      expect(state.isError, true);
      expect(state.isLoading, false);
      expect(state.isSuccess, false);
    });

    test('isLoading returns false when status is initial', () {
      final state = DataState(status: Status.initial);
      expect(state.isLoading, false);
      expect(state.isSuccess, false);
      expect(state.isError, false);
    });
  });
}
