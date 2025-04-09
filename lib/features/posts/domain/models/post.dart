import 'package:blinq_pay/features/users/domain/models/user.dart';

class Post {
  final String id, userId, username;
  final String description;
  final String? thumbnail, link;
  final DateTime timestamp;
  final bool noMedia, video;

  final User user;

  Post({
    required this.id,
    required this.userId,
    required this.description,
    required this.username,
    required this.thumbnail,
    required this.link,
    required this.timestamp,
    required this.noMedia,
    required this.video,
    required this.user,
  });

  /// Creates a Post object from JSON data.
  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        userId = json['userId'] as String,
        username = json['username'] as String,
        description = json['description'] as String,
        thumbnail = json['thumbnail'] as String?,
        link = json['link'] as String?,
        timestamp = DateTime.parse(json['timestamp']),
        noMedia = json['no_media'] ?? false,
        video = json['video'] ?? false,
        user = User.fromJson(json['user']);

  /// Converts the Post object to JSON format.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'description': description,
      'username': username,
      'thumbnail': thumbnail,
      'link': link,
      'timestamp': timestamp.toIso8601String(),
      'no_media': noMedia,
      'video': video,
    };
  }

  @override
  int get hashCode => id.hashCode | runtimeType.hashCode;

  @override
  bool operator ==(Object other) => other is Post && other.id == id;
}
