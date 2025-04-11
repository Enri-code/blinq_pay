import 'package:blinq_pay/core/utils/data_helpers.dart';
import 'package:blinq_pay/features/posts/domain/datasource/posts_datasource.dart';
import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:either_dart/either.dart';

class PostsRepositoryImpl {
  PostsRepositoryImpl(this.datasource);
  final PostsDatasource datasource;

  FutureEitherFailureOr<List<Post>> getPosts({
    int page = 1,
    required PostsDatasourceParam param,
  }) async {
    try {
      final posts = await datasource.getPosts(page: page, param: param);
      return Right(posts);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
