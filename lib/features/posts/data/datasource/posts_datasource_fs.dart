// A Firestore implementation of the [PostsDatasource] interface for fetching posts.
//
// This class interacts with the Firestore database to retrieve posts and their associated user data.
// It uses the [FSGetPostsDatasourceParams] to handle pagination and fetch posts after a specific document ID.
//
// Methods:
// - [getPosts]: Fetches a list of posts from the Firestore database. It retrieves the posts,
//   their associated user data, and combines them into a list of [Post] objects.
//
// Throws:
// - [Failure]: If there is an error during fetching or processing posts or user data.
import 'package:blinq_pay/core/utils/data_helpers.dart';
import 'package:blinq_pay/features/posts/domain/datasource/posts_datasource.dart';
import 'package:blinq_pay/features/posts/domain/models/post.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FSGetPostsDatasourceParams extends PostsDatasourceParam {
  final String? lastDocId;

  FSGetPostsDatasourceParams({this.lastDocId});
}

class FSPostsDatasource extends PostsDatasource {
  final FirebaseFirestore firestore;
  FSPostsDatasource(this.firestore);

  ///[PostsDatasourceParam] must be a [FSGetPostsDatasourceParams]
  @override

  /// Fetches posts and their associated user data from Firestore.
  ///
  /// Retrieves posts from the `posts` collection and their user data from the `users` collection.
  /// Supports pagination using `lastDocId` in [param].
  ///
  /// Throws:
  /// - [Failure] if fetching or parsing posts or user data fails.
  ///
  /// Returns:
  /// A [Future] with a list of [Post] objects.
  ///
  /// Parameters:
  /// - [page]: Page number, defaults to 0.
  /// - [param]: Must be [FSGetPostsDatasourceParams] with optional `lastDocId`.

  @override
  Future<List<Post>> getPosts({
    int page = 0,
    required PostsDatasourceParam param,
  }) async {
    QuerySnapshot<Map<String, dynamic>>? postsSnap;

    try {
      // Query posts collection, ordered by 'id', with optional pagination.
      var coll = firestore.collection('posts').orderBy('id');
      if ((param as FSGetPostsDatasourceParams).lastDocId != null) {
        coll = coll.startAfter([param.lastDocId]);
      }
      postsSnap = await coll.limit(15).get();
    } catch (e) {
      throw Failure('There was a problem fetching posts');
    }

    // Parse posts data.
    final postsData = postsSnap.docs.map((e) => e.data()).toList();
    List<PostData>? posts;
    try {
      posts = postsData.map((e) => PostData.fromJson(e)).toList();
    } catch (e) {
      throw Failure('There was a problem loading posts');
    }

    QuerySnapshot<Map<String, dynamic>>? usersSnap;
    try {
      // Fetch user data for the posts.
      usersSnap = await firestore
          .collection('users')
          .where('username', whereIn: posts.map((e) => e.username).toSet())
          .get();
    } catch (e) {
      throw Failure("Error fetching posts' contents");
    }

    // Parse user data.
    List<User>? users;
    try {
      users = usersSnap.docs.map((e) => User.fromJson(e.data())).toList();
    } catch (e) {
      throw Failure("Error loading posts' contents");
    }

    // Attach user data to posts.
    for (var i = 0; i < postsData.length; i++) {
      postsData[i]['user'] = users.firstWhere(
        (user) => user.username == posts![i].username,
      );
    }

    // Return combined posts with user data.
    return postsData.map((e) => Post.fromJson(e)).toList();
  }
}
