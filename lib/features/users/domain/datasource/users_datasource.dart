
import 'package:blinq_pay/features/users/domain/models/user.dart';

abstract class UsersDatasourceParam {}

abstract class UsersDatasource {
  Future<List<User>> getUsers({
    int page = 0,
    required UsersDatasourceParam param,
  });
}
