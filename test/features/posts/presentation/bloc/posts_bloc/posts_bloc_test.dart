import 'package:blinq_pay/features/posts/data/datasource/posts_datasource_fs.dart';
import 'package:blinq_pay/features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:blinq_pay/core/utils/data_helpers.dart';
import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:blinq_pay/features/posts/data/repository/posts_repository.dart';
import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helper_data.dart';
import 'posts_bloc_test.mocks.dart';

@GenerateMocks([PostsRepositoryImpl])
void main() {
  late PostsBloc postsBloc;
  late MockPostsRepositoryImpl mockPostsRepository;

  final postList = [post1, post2];
  setUp(() {
    mockPostsRepository = MockPostsRepositoryImpl();

    postsBloc = PostsBloc(mockPostsRepository);
    provideDummy<Either<Failure, List<Post>>>(
      Right<Failure, List<Post>>(postList),
    );
  });

  group('PostsBloc', () {
    test('initial state is PostsInitialState', () {
      expect(postsBloc.state, isA<PostsInitialState>());
    });

    blocTest<PostsBloc, PostsState>(
      'emits loading and then success when GetPostsEvent is added and posts are fetched successfully',
      act: (bloc) => bloc.add(GetPostsEvent()),
      build: () => postsBloc,
      setUp: () {
        when(mockPostsRepository.getPosts(
          page: 1,
          param: argThat(isA<FSGetPostsDatasourceParams>(), named: 'param'),
        )).thenAnswer((_) async => Right<Failure, List<Post>>(postList));
      },
      expect: () => [
        PostsInitialState(dataState: DataState(status: Status.loading)),
        FoundPostsState(
          data: PaginationData(
            page: 1,
            data: postList,
            hasNextPage: postList.length == 15,
          ),
          dataState: DataState(status: Status.success),
        ),
      ],
      verify: (_) {
        verify(mockPostsRepository.getPosts(
          page: 1,
          param: argThat(isA<FSGetPostsDatasourceParams>(), named: 'param'),
        )).called(1);
      },
    );

    blocTest<PostsBloc, PostsState>(
      'emits error when GetPostsEvent is added and posts fetch fails',
      act: (bloc) => bloc.add(GetPostsEvent()),
      build: () => postsBloc,
      setUp: () {
        when(mockPostsRepository.getPosts(
          page: 1,
          param: argThat(isA<FSGetPostsDatasourceParams>(), named: 'param'),
        )).thenAnswer((_) async => Left(Failure('Failed to fetch posts')));
      },
      expect: () => [
        PostsInitialState(dataState: DataState(status: Status.loading)),
        NoPostsState(
          dataState: DataState(
            error: Failure('Failed to fetch posts'),
            status: Status.error,
          ),
        ),
      ],
      verify: (_) {
        verify(mockPostsRepository.getPosts(
          page: 1,
          param: argThat(isA<FSGetPostsDatasourceParams>(), named: 'param'),
        )).called(1);
      },
    );

    blocTest<PostsBloc, PostsState>(
      'emits loading and then success when GetMorePostsEvent is added and more posts are fetched successfully',
      act: (bloc) => bloc.add(GetMorePostsEvent()),
      build: () => postsBloc,
      setUp: () {
        when(mockPostsRepository.getPosts(
          page: 2,
          param: argThat(isA<FSGetPostsDatasourceParams>(), named: 'param'),
        )).thenAnswer((_) async => Right(postList));
      },
      seed: () => FoundPostsState(
        data: PaginationData(
          data: postList,
          hasNextPage: postList.length == 15,
          page: 1,
        ),
        dataState: DataState(status: Status.success),
      ),
      expect: () => [
        FoundPostsState(
          data: PaginationData(
            data: postList,
            hasNextPage: postList.length == 15,
            page: 1,
          ),
          dataState: DataState(status: Status.loading),
        ),
        FoundPostsState(
          data: PaginationData(
            data: [...postList, ...postList],
            hasNextPage: postList.length == 15,
            page: 2,
          ),
          dataState: DataState(status: Status.success),
        ),
      ],
      verify: (_) {
        verify(mockPostsRepository.getPosts(
          page: 2,
          param: argThat(isA<FSGetPostsDatasourceParams>(), named: 'param'),
        )).called(1);
      },
    );

    blocTest<PostsBloc, PostsState>(
      'emits error when GetMorePostsEvent is added and fetch fails',
      act: (bloc) => bloc.add(GetMorePostsEvent()),
      build: () => postsBloc,
      setUp: () {
        when(mockPostsRepository.getPosts(
          page: 2,
          param: argThat(isA<FSGetPostsDatasourceParams>(), named: 'param'),
        )).thenAnswer((_) async => Left(Failure('Failed to fetch more posts')));
      },
      seed: () => FoundPostsState(
        data: PaginationData(
          data: postList,
          hasNextPage: postList.length == 15,
          page: 1,
        ),
        dataState: DataState(status: Status.success),
      ),
      expect: () => [
        FoundPostsState(
          data: PaginationData(
            data: postList,
            hasNextPage: postList.length == 15,
            page: 1,
          ),
          dataState: DataState(status: Status.loading),
        ),
        FoundPostsState(
          dataState: DataState(
            error: Failure('Failed to fetch more posts'),
            status: Status.error,
          ),
          data: PaginationData(
            data: postList,
            hasNextPage: postList.length == 15,
            page: 1,
          ),
        ),
      ],
      verify: (_) {
        verify(mockPostsRepository.getPosts(
          page: 2,
          param: argThat(isA<FSGetPostsDatasourceParams>(), named: 'param'),
        )).called(1);
      },
    );
  });

  tearDown(() {
    postsBloc.close();
  });
}
