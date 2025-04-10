part of 'users_bloc.dart';

sealed class UsersEvent {}

class GetUsersEvent extends UsersEvent {}

class GetMoreUsersEvent extends UsersEvent {}
