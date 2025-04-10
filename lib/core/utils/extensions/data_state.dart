import 'package:blinq_pay/core/utils/data_helpers.dart';

extension DataStateExt on DataState {
  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isError => status == Status.error;
}
