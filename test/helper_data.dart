import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';

final user1 = User(
  userId: 'userId1',
  username: 'username1',
  name: 'Dave Blaine',
  bio: 'bio1',
  photo: 'photo1',
);
final user2 = User(
  userId: 'userId2',
  username: 'username2',
  name: 'Eric Onyeulo',
  bio: 'bio2',
  photo: 'photo2',
);

final post1 = Post(
  id: 'id1',
  userId: 'userId1',
  description: 'description1',
  username: 'username1',
  timestamp: DateTime.now(),
  noMedia: false,
  video: true,
  user: user1,
  link: 'link1',
  thumbnail: 'thumbnail1',
);

final post2 = Post(
  id: 'id2',
  userId: 'userId2',
  description: 'description2',
  username: 'username2',
  timestamp: DateTime.now().subtract(Duration(days: 1)),
  noMedia: false,
  video: false,
  user: user2,
  link: 'link2',
  thumbnail: 'thumbnail2',
);
