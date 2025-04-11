import 'package:bloc_test/bloc_test.dart';
import 'package:blinq_pay/features/users/data/datasource/users_datasource_fs.dart';
import 'package:blinq_pay/features/users/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:blinq_pay/core/utils/data_helpers.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:blinq_pay/features/users/data/repository/users_repository.dart';
import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helper_data.dart';
import 'users_bloc_test.mocks.dart';

@GenerateMocks([UsersRepositoryImpl])
void main() {
  late UsersBloc usersBloc;
  late MockUsersRepositoryImpl mockUsersRepository;

  final userList = [user1, user2];
  setUp(() {
    mockUsersRepository = MockUsersRepositoryImpl();
    usersBloc = UsersBloc(mockUsersRepository);

    provideDummy<Either<Failure, List<User>>>(
      Right<Failure, List<User>>(userList),
    );
  });

  group('UsersBloc', () {
    test('initial state is UsersInitialState', () {
      expect(usersBloc.state, isA<UsersInitialState>());
    });

    blocTest<UsersBloc, UsersState>(
      'emits loading and then success when GetUsersEvent is added and users are fetched successfully',
      act: (bloc) => bloc.add(GetUsersEvent()),
      build: () => usersBloc,
      setUp: () {
        when(mockUsersRepository.getUsers(
          page: 1,
          param: argThat(isA<FSGetUsersDatasourceParams>(), named: 'param'),
        )).thenAnswer((_) async => Right<Failure, List<User>>(userList));
      },
      expect: () => [
        UsersInitialState(dataState: DataState(status: Status.loading)),
        FoundUsersState(
          data: PaginationData(
            page: 1,
            data: userList,
            hasNextPage: userList.length == 15,
          ),
          dataState: DataState(status: Status.success),
        ),
      ],
      verify: (_) {
        verify(mockUsersRepository.getUsers(
          page: 1,
          param: argThat(isA<FSGetUsersDatasourceParams>(), named: 'param'),
        )).called(1);
      },
    );

    blocTest<UsersBloc, UsersState>(
      'emits error when GetUsersEvent is added and users fetch fails',
      act: (bloc) => bloc.add(GetUsersEvent()),
      build: () => usersBloc,
      setUp: () {
        when(mockUsersRepository.getUsers(
          page: 1,
          param: argThat(isA<FSGetUsersDatasourceParams>(), named: 'param'),
        )).thenAnswer((_) async => Left(Failure('Failed to fetch users')));
      },
      expect: () => [
        UsersInitialState(dataState: DataState(status: Status.loading)),
        NoUsersState(
          dataState: DataState(
            error: Failure('Failed to fetch users'),
            status: Status.error,
          ),
        ),
      ],
      verify: (_) {
        verify(mockUsersRepository.getUsers(
          page: 1,
          param: argThat(isA<FSGetUsersDatasourceParams>(), named: 'param'),
        )).called(1);
      },
    );

    blocTest<UsersBloc, UsersState>(
      'emits loading and then success when GetMoreUsersEvent is added and more users are fetched successfully',
      act: (bloc) => bloc.add(GetMoreUsersEvent()),
      build: () => usersBloc,
      setUp: () {
        when(mockUsersRepository.getUsers(
          page: 2,
          param: argThat(isA<FSGetUsersDatasourceParams>(), named: 'param'),
        )).thenAnswer((_) async => Right(userList));
      },
      seed: () => FoundUsersState(
        data: PaginationData(
          data: userList,
          hasNextPage: userList.length == 15,
          page: 1,
        ),
        dataState: DataState(status: Status.success),
      ),
      expect: () => [
        FoundUsersState(
          data: PaginationData(
            data: userList,
            hasNextPage: userList.length == 15,
            page: 1,
          ),
          dataState: DataState(status: Status.loading),
        ),
        FoundUsersState(
          data: PaginationData(
            data: [...userList, ...userList],
            hasNextPage: userList.length == 15,
            page: 2,
          ),
          dataState: DataState(status: Status.success),
        ),
      ],
      verify: (_) {
        verify(mockUsersRepository.getUsers(
          page: 2,
          param: argThat(isA<FSGetUsersDatasourceParams>(), named: 'param'),
        )).called(1);
      },
    );

    blocTest<UsersBloc, UsersState>(
      'emits error when GetMoreUsersEvent is added and fetch fails',
      act: (bloc) => bloc.add(GetMoreUsersEvent()),
      build: () => usersBloc,
      setUp: () {
        when(mockUsersRepository.getUsers(
          page: 2,
          param: argThat(isA<FSGetUsersDatasourceParams>(), named: 'param'),
        )).thenAnswer((_) async => Left(Failure('Failed to fetch more users')));
      },
      seed: () => FoundUsersState(
        data: PaginationData(
          data: userList,
          hasNextPage: userList.length == 15,
          page: 1,
        ),
        dataState: DataState(status: Status.success),
      ),
      expect: () => [
        FoundUsersState(
          data: PaginationData(
            data: userList,
            hasNextPage: userList.length == 15,
            page: 1,
          ),
          dataState: DataState(status: Status.loading),
        ),
        FoundUsersState(
          dataState: DataState(
            error: Failure('Failed to fetch more users'),
            status: Status.error,
          ),
          data: PaginationData(
            data: userList,
            hasNextPage: userList.length == 15,
            page: 1,
          ),
        ),
      ],
      verify: (_) {
        verify(mockUsersRepository.getUsers(
          page: 2,
          param: argThat(isA<FSGetUsersDatasourceParams>(), named: 'param'),
        )).called(1);
      },
    );
  });

  tearDown(() {
    usersBloc.close();
  });
}
