import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xopinionx/core/api/models/user_model.dart';

class UserFunctions {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> createUser(UserModel user) async {
    //TODO: Check if user is already registered before calling this function
    final _docId = _firestore.collection('users').doc().id;
    await _firestore
        .collection('users')
        .doc(_docId)
        .set(
          UserModel(
            id: _docId,
            fname: user.fname,
            lname: user.lname,
            email: user.email,
            sessionBalance: user.sessionBalance,
            eduYear: user.eduYear,
            overallReview: user.overallReview,
            languagePreferences: user.languagePreferences,
            registrationStatus: user.registrationStatus,
            userTags: user.userTags,
          ).toJson(),

          //TODO: merge = false option is probably unavailable in new update
        )
        .catchError((e) => {});
  }

  static Future<void> deleteUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).delete();
  }

  static Future<UserModel> getCurrentUser() async {
    final _firebaseUser = FirebaseAuth.instance.currentUser;
    final _email = _firebaseUser.email;
    final _queryList = await _firestore
        .collection('users')
        .where('email', isEqualTo: _email)
        .get();
    final _doc = _queryList.docs;
    final _data = _doc[0].data();
    final UserModel _user = UserModel.fromJson(_data);
    return _user;
  }

  static Future<void> updateUserDetails(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toJson());
  }

  static Future<void> getUserById({@required String id}) async {}
}
