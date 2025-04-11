import 'package:blinq_pay/core/utils/data_helpers.dart';
import 'package:blinq_pay/features/users/domain/datasource/users_datasource.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:either_dart/either.dart';

class UsersRepositoryImpl {
  UsersRepositoryImpl(this.datasource);
  final UsersDatasource datasource;

  FutureEitherFailureOr<List<User>> getUsers({
    int page = 1,
    required UsersDatasourceParam param,
  }) async {
    try {
      final users = await datasource.getUsers(page: page, param: param);
      return Right(users);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
