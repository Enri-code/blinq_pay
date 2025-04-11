import 'package:blinq_pay/features/users/domain/datasource/users_datasource.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';

class MockGetUsersDatasourceParams extends UsersDatasourceParam {}

class MockUsersDatasource extends UsersDatasource {
  @override
  Future<List<User>> getUsers({
    int page = 0,
    required UsersDatasourceParam param,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return [
    ];
  }
}
