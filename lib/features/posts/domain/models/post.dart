import 'package:blinq_pay/features/users/domain/models/user.dart';

class PostData {
  final String id, userId, username;
  final String description;
  final String thumbnail, link;
  final bool noMedia, video;

  PostData({
    required this.id,
    required this.userId,
    required this.description,
    required this.username,
    this.thumbnail = '',
    this.link = '',
    required this.noMedia,
    required this.video,
  });

  /// Creates a Post object from JSON data.
  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      id: json['id'] as String,
      userId: json['userId'] as String,
      description: json['description'] as String,
      username: json['username'] as String,
      thumbnail: json['thumbnail'] as String? ?? '',
      link: json['link'] as String? ?? '',
      noMedia: json['no_media'] ?? false,
      video: json['video'] ?? false,
    );
  }

  /// Converts the Post object to JSON format.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'description': description,
      'username': username,
      'thumbnail': thumbnail,
      'link': link,
      'no_media': noMedia,
      'video': video,
    };
  }

  @override
  int get hashCode => id.hashCode | runtimeType.hashCode;

  @override
  bool operator ==(Object other) => other is PostData && other.id == id;
}

class Post extends PostData {
  Post({
    required super.id,
    required super.userId,
    required super.description,
    required super.username,
    super.thumbnail,
    super.link,
    required this.timestamp,
    required super.noMedia,
    required super.video,
    required this.user,
  });

  final DateTime timestamp;
  final User user;

  /// Creates a Post object from JSON data.
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      userId: json['userId'] as String,
      description: json['description'] as String,
      username: json['username'] as String,
      thumbnail: json['thumbnail'] as String? ?? '',
      link: json['link'] as String? ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      noMedia: json['no_media'] ?? false,
      video: json['video'] ?? false,
      user: User.fromJson(json['user']),
    );
  }

  /// Converts the Post object to JSON format.
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson()
      ..addAll({
        'user': user.toJson(),
        'timestamp': timestamp.toIso8601String(),
      });
    return data;
  }

  @override
  int get hashCode => super.hashCode | user.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Post && other.id == id && other.user == user;
}
