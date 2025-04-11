import 'package:blinq_pay/features/users/data/repository/users_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:blinq_pay/features/users/domain/datasource/users_datasource.dart';
import 'package:blinq_pay/core/utils/data_helpers.dart'; // adjust import path
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper_data.dart';
import 'users_repository_test.mocks.dart';

@GenerateMocks([UsersDatasource, UsersDatasourceParam])
void main() {
  late MockUsersDatasourceParam param;
  late MockUsersDatasource mockDatasource;

  late UsersRepositoryImpl repository;

  setUp(() {
    param = MockUsersDatasourceParam();
    mockDatasource = MockUsersDatasource();

    repository = UsersRepositoryImpl(mockDatasource);
  });

  group('getUsers', () {
    test('should return a list of users when the datasource is successful',
        () async {
      final mockUsers = [user1];

      when(mockDatasource.getUsers(page: 0, param: param))
          .thenAnswer((_) async => mockUsers);

      final result = await repository.getUsers(page: 0, param: param);

      expect(result.isRight, true);
      result.fold(
        (failure) => fail('Expected a success but got a failure: $failure'),
        (users) => expect(users, mockUsers),
      );
    });

    test('should return a Failure when the datasource throws a Failure',
        () async {
      final failure = Failure('Datasource error');

      when(mockDatasource.getUsers(page: 0, param: param)).thenThrow(failure);

      final result = await repository.getUsers(page: 0, param: param);

      expect(result.isLeft, true);
      result.fold(
        (error) => expect(error.message, 'Datasource error'),
        (users) => fail('Expected a failure but got users: $users'),
      );
    });

    test('should return a generic Failure for unknown errors', () async {
      when(mockDatasource.getUsers(page: 0, param: param))
          .thenThrow(Exception('Unknown error'));

      final result = await repository.getUsers(page: 0, param: param);

      expect(result.isLeft, true);
      result.fold(
        (error) => expect(error.message, 'Exception: Unknown error'),
        (users) => fail('Expected a failure but got users: $users'),
      );
    });
  });
}
