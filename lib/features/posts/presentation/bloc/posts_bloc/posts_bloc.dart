import 'package:blinq_pay/core/utils/data_helpers.dart';
import 'package:blinq_pay/features/posts/data/datasource/posts_datasource_fs.dart';
import 'package:blinq_pay/features/posts/data/repository/posts_repository.dart';
import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepositoryImpl repo;

  PostsBloc(this.repo) : super(PostsInitialState()) {
    on<GetPostsEvent>((event, emit) async {
      emit(PostsInitialState(dataState: DataState(status: Status.loading)));

      final posts = await repo.getPosts(
        page: 0,
        param: FSGetPostsDatasourceParams(),
      );

      posts.either((left) {
        emit(NoPostsState(
          dataState: DataState(error: left, status: Status.error),
        ));
      }, (right) {
        emit(FoundPostsState(
          data: PaginationData(
            data: right,
            hasNextPage: right.length == 15,
          ),
          dataState: DataState(status: Status.success),
        ));
      });
    });
    on<GetMorePostsEvent>((event, emit) async {
      final currentState = state as FoundPostsState;

      emit(FoundPostsState(
        data: currentState.data,
        dataState: DataState(status: Status.loading),
      ));

      final posts = await repo.getPosts(
        page: currentState.data.page + 1,
        param: FSGetPostsDatasourceParams(
          lastDocId: currentState.data.data.last.id,
        ),
      );

      posts.either((left) {
        emit(FoundPostsState(
          dataState: DataState(error: left, status: Status.error),
          data: currentState.data,
        ));
      }, (right) {
        emit(FoundPostsState(
          data: PaginationData(
            data: [...currentState.data.data, ...right],
            hasNextPage: right.length == 15,
            page: currentState.data.page + 1,
          ),
          dataState: DataState(status: Status.success),
        ));
      });
    });
  }
}
