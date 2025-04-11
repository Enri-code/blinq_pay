import 'dart:math';

import 'package:blinq_pay/features/posts/domain/datasource/posts_datasource.dart';
import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';

class MockGetPostsDatasourceParams extends PostsDatasourceParam {}

class MockPostsDatasource extends PostsDatasource {
  @override
  Future<List<Post>> getPosts({
    int page = 0,
    required PostsDatasourceParam param,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(
      15,
      (index) => Post(
        id: 'id-$index',
        userId: 'userId',
        description: "Lorem Ipsum is simply dummy text of the printing and typesetting"
                " industry. Lorem Ipsum has been the industry's standard dummy text"
                " ever since the 1500s, when an unknown printer took a galley of "
                "type and scrambled it to make a type specimen book. It has survived"
                " not only five centuries, but also the leap into electronic "
                "typesetting, remaining essentially unchanged. It was popularised in"
                " the 1960s with the release of Letraset sheets containing Lorem "
                "Ipsum passages, and more recently with desktop publishing software "
                "like Aldus PageMaker including versions of Lorem Ipsum."
            .substring(Random().nextInt(500)),
        username: 'username',
        thumbnail: index % 2 == 0
            ? 'https://cdn.dribbble.com/users/14790058/avatars/normal/2283a992ab80bcd500f7b950ba865cf1.jpg?1699074419'
            : 'https://cdn.dribbble.com/userupload/8282521/file/original-26d484aaa28576dafce6b1f7dc0b2bf7.png?resize=752x&vertical=center',
        link: index % 2 == 0
            ? 'https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_30mb.mp4'
            : 'https://cdn.dribbble.com/userupload/8282521/file/original-26d484aaa28576dafce6b1f7dc0b2bf7.png?resize=752x&vertical=center',
        timestamp: DateTime.now().subtract(Duration(minutes: index * index)),
        noMedia: index % 3 == 2,
        video: index % 2 == 0,
        user: User(
          userId: 'userId',
          username: 'username',
          name: 'Full Name',
          bio: 'bio',
          photo:
              'https://cdn.dribbble.com/users/14790058/avatars/normal/2283a992ab80bcd500f7b950ba865cf1.jpg?1699074419',
        ),
      ),
    );
  }
}
