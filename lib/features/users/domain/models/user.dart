class User {
  final String userId;
  final String username;
  final String name;
  final String bio;
  final String photo;

  User({
    required this.userId,
    required this.username,
    required this.name,
    required this.bio,
    required this.photo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      bio: json['bio'] as String,
      photo: json['photo'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'name': name,
      'bio': bio,
      'photo': photo,
    };
  }
}