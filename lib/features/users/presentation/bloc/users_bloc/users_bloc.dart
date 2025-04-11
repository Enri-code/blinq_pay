import 'package:blinq_pay/core/utils/data_helpers.dart';
import 'package:blinq_pay/features/users/data/datasource/users_datasource_fs.dart';
import 'package:blinq_pay/features/users/data/repository/users_repository.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepositoryImpl repo;

  UsersBloc(this.repo) : super(UsersInitialState()) {
    on<GetUsersEvent>((event, emit) async {
      emit(UsersInitialState(dataState: DataState(status: Status.loading)));
     
      final posts = await repo.getUsers(
        page: 1,
        param: FSGetUsersDatasourceParams(),
      );

      posts.either((left) {
        emit(NoUsersState(
          dataState: DataState(error: left, status: Status.error),
        ));
      }, (right) {
        emit(FoundUsersState(
          data: PaginationData(
            page: 1,
            data: right,
            hasNextPage: right.length == 15,
          ),
          dataState: DataState(status: Status.success),
        ));
      });
    });
    on<GetMoreUsersEvent>((event, emit) async {
      final currentState = state as FoundUsersState;

      emit(FoundUsersState(
        data: currentState.data,
        dataState: DataState(status: Status.loading),
      ));

      final posts = await repo.getUsers(
        page: (state as FoundUsersState).data.page + 1,
        param: FSGetUsersDatasourceParams(
          lastDocId: (state as FoundUsersState).data.data.last.userId,
        ),
      );

      posts.either((left) {
        emit(FoundUsersState(
          dataState: DataState(error: left, status: Status.error),
          data: currentState.data,
        ));
      }, (right) {
        emit(FoundUsersState(
          data: PaginationData(
            data: [...currentState.data.data, ...right],
            hasNextPage: right.length == 15,
            page: currentState.data.page + 1,
          ),
          dataState: DataState(status: Status.success),
        ));
      });
    }, transformer: droppable());
  }
}
