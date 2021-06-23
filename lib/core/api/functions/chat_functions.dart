import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xopinionx/core/api/models/chat_model.dart';
import 'package:xopinionx/global/global_helpers.dart';

// ignore: avoid_classes_with_only_static_members
class ChatFunctions {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> createChat({@required ChatModel chatModel}) async {
    await _firestore
        .collection('chats')
        .doc(chatModel.chatId)
        .set(chatModel.toJson());
  }

  static Future<void> deleteChat({ChatModel chatModel}) async {
    await _firestore.collection('chats').doc(chatModel.chatId).delete();
  }

  static Future<void> getChats({ChatModel chatModel}) async {
    //TODO: implement
  }

  List<ChatModel> _userChatList(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) => ChatModel.fromJson(e.data())).toList();
  }

  Stream<List<ChatModel>> get userTeacherList {
    final Stream<QuerySnapshot> _q = _firestore
        .collection('chats')
        .where('teacherId', isEqualTo: globalUser.id)
        .orderBy('dateUpdated')
        .snapshots();
    return _q.map(_userChatList);
  }

  Stream<List<ChatModel>> get userStudentList {
    final Stream<QuerySnapshot> _q = _firestore
        .collection('chats')
        .where('studentId', isEqualTo: globalUser.id)
        .orderBy('dateUpdated')
        .snapshots();
    return _q.map(_userChatList);
  }
}
