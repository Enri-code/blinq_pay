part of 'posts_bloc.dart';

sealed class PostsState {
  final DataState? dataState;
  const PostsState({this.dataState});
}

final class PostsInitialState extends PostsState {
  const PostsInitialState({super.dataState});
}

final class FoundPostsState extends PostsState {
  final PaginationData<Post> data;
  const FoundPostsState({required this.data, super.dataState});
}

final class NoPostsState extends PostsState {
  const NoPostsState({super.dataState});
}

