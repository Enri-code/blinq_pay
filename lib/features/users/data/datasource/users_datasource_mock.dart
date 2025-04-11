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
    return List.generate(
      15,
      (index) => User(
        userId: 'userId-$index',
        username: 'username$index',
        name: 'Full Name',
        bio: 'bio',
        photo:
            'https://cdn.dribbble.com/users/14790058/avatars/normal/2283a992ab80bcd500f7b950ba865cf1.jpg?1699074419',
      ),
    );
  }
}
