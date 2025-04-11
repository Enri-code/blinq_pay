part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  final DataState dataState;
  const PostsState({this.dataState = const DataState()});

  @override
  List<Object?> get props => [dataState];
}

final class PostsInitialState extends PostsState {
  const PostsInitialState({super.dataState});
}

final class FoundPostsState extends PostsState {
  final PaginationData<Post> data;
  const FoundPostsState({required this.data, super.dataState});

  @override
  List<Object?> get props => [dataState, data];
}

final class NoPostsState extends PostsState {
  const NoPostsState({super.dataState});
}
