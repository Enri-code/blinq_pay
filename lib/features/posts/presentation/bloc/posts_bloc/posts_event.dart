part of 'posts_bloc.dart';

sealed class PostsEvent {}

class GetPostsEvent extends PostsEvent {}

class GetMorePostsEvent extends PostsEvent {}
