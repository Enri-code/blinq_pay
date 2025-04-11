import 'package:blinq_pay/core/utils/data_helpers.dart';
import 'package:blinq_pay/features/users/domain/datasource/users_datasource.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FSGetUsersDatasourceParams extends UsersDatasourceParam {
  final String? lastDocId;

  FSGetUsersDatasourceParams({this.lastDocId});
}

class FSUsersDatasource extends UsersDatasource {
  final FirebaseFirestore firestore;
  FSUsersDatasource(this.firestore);

  ///[FSUsersDatasource] must be a [FSGetUsersDatasourceParams]
  @override
  Future<List<User>> getUsers({
    int page = 0,

    /// Here is [FSGetUsersDatasourceParams]
    required UsersDatasourceParam param,
  }) async {
    QuerySnapshot<Map<String, dynamic>>? usersSnap;
    try {
      var coll = firestore.collection('posts').orderBy('id');
      if ((param as FSGetUsersDatasourceParams).lastDocId != null) {
        coll = coll.startAfter([param.lastDocId]);
      }

      usersSnap = await coll.limit(15).get();
    } catch (e) {
      throw Failure('There was a problem fetching users');
    }

    List<User>? users;
    try {
      users = usersSnap.docs.map((e) => User.fromJson(e.data())).toList();
    } catch (e) {
      throw Failure('There was a problem loading users');
    }
    return users;
  }
}
