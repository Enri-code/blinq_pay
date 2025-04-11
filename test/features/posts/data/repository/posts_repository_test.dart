import 'package:blinq_pay/features/posts/data/repository/posts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:blinq_pay/features/posts/domain/datasource/posts_datasource.dart';
import 'package:blinq_pay/core/utils/data_helpers.dart'; // adjust import path

import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../../../../helper_data.dart';
import 'posts_repository_test.mocks.dart';

@GenerateMocks([PostsDatasourceParam, PostsDatasource])
void main() {
  late MockPostsDatasourceParam param;
  late MockPostsDatasource mockDatasource;
  
  late PostsRepositoryImpl repository;

  setUp(() {
    param = MockPostsDatasourceParam();
    mockDatasource = MockPostsDatasource();

    repository = PostsRepositoryImpl(mockDatasource);
  });

  group('getPosts', () {
    test('should return a list of posts when the datasource is successful',
        () async {
      final mockPosts = [post1];

      when(mockDatasource.getPosts(page: 1, param: param))
          .thenAnswer((_) async => mockPosts);

      final result = await repository.getPosts(page: 1, param: param);

      expect(result.isRight, true);
      result.fold(
        (failure) => fail('Expected a success but got a failure: $failure'),
        (posts) => expect(posts, mockPosts),
      );
    });

    test('should return a Failure when the datasource throws a Failure',
        () async {
      final failure = Failure('Datasource error');

      when(mockDatasource.getPosts(page: 1, param: param)).thenThrow(failure);

      final result = await repository.getPosts(page: 1, param: param);

      expect(result.isLeft, true);
      result.fold(
        (error) => expect(error.message, 'Datasource error'),
        (posts) => fail('Expected a failure but got posts: $posts'),
      );
    });

    test('should return a generic Failure for unknown errors', () async {
      when(mockDatasource.getPosts(page: 1, param: param))
          .thenThrow(Exception('Unknown error'));

      final result = await repository.getPosts(page: 1, param: param);

      expect(result.isLeft, true);
      result.fold(
        (error) => expect(error.message, 'Exception: Unknown error'),
        (posts) => fail('Expected a failure but got posts: $posts'),
      );
    });
  });
}
