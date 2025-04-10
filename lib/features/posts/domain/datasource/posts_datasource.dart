import 'package:blinq_pay/features/posts/domain/models/post.dart';

abstract class PostsDatasourceParam {}

abstract class PostsDatasource {
  Future<List<Post>> getPosts({
    int page = 0,
    required PostsDatasourceParam param,
  });
}
