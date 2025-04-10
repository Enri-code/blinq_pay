part of 'users_bloc.dart';

sealed class UsersState {
  final DataState? dataState;
  const UsersState({this.dataState});
}

final class UsersInitialState extends UsersState {
  const UsersInitialState({super.dataState});
}

final class FoundUsersState extends UsersState {
  final PaginationData<User> data;
  const FoundUsersState({required this.data, super.dataState});
}

final class NoUsersState extends UsersState {
  const NoUsersState({super.dataState});
}
