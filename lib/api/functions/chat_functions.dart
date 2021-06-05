import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xopinionx/api/models/chat_model.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';

// ignore: avoid_classes_with_only_static_members
class ChatFunctions {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> createChat({@required ChatModel chatModel}) async {
    //TODO: implement
    final _docId = _firestore.collection('chats').doc().id;
    await _firestore.collection('chats').doc(_docId).set(
          ChatModel(
            studentId: chatModel.studentId,
            teacherId: chatModel.teacherId,
            problemId: chatModel.problemId,
            chatId: _docId,
            review: chatModel.review,
          ).toJson(),
        );
  }

  static Future<void> deleteChat({ChatModel chatModel}) async {
    //TODO: maybe also delete from the local list or update the list
    await _firestore.collection('chats').doc(chatModel.chatId).delete();
  }

  static Future<void> getChats({ChatModel chatModel}) async {
    //TODO: implement
  }

  //TODO: implement chat stream
}
