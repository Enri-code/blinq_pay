import 'package:blinq_pay/features/posts/domain/datasource/posts_datasource.dart';
import 'package:blinq_pay/features/posts/domain/models/post.dart';

class MockGetPostsDatasourceParams extends PostsDatasourceParam {}

class MockPostsDatasource extends PostsDatasource {
  @override
  Future<List<Post>> getPosts({
    int page = 0,
    required PostsDatasourceParam param,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return [];
  }
}
