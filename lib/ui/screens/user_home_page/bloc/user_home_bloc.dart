import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/core/api/functions/chat_functions.dart';
import 'package:xopinionx/core/api/models/chat_model.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';

part 'user_home_state.dart';
part 'user_home_event.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  UserHomeBloc() : super(UserHomeIntial());

  @override
  Stream<UserHomeState> mapEventToState(UserHomeEvent event) async* {
    try {
      if (event is UserHomeReviewsRequested) {}
      if (event is UserHomeHistoryRequested) {}
      if (event is UserHomeLogoutRequested) {}
      if (event is GlobalProblemsRequested) {
        yield UserHomeInProgress();
        logger.d("loading problems");
        await loadGlobalProblems();
        logger.d("problems loaded");
        yield UserHomeLoaded();
      }
      if (event is UserHomeBlogRequested) {}
      if (event is UserHomeDonateRequested) {}
      if (event is UserHomeAskQueryRequested) {
        yield UserHomeInProgress();
        if (globalUser.sessionBalance >= 3) {
          logger.i('Askign Queries not allowed');
          yield QueryNotAllowed();
        } else {
          logger.i('Ask Query Loaded');
          yield AskQueryLoaded();
        }
      }
      if (event is UserHomeChatRequested) {
        yield UserHomeInProgress();
        final _firestore = FirebaseFirestore.instance;
        logger.i('Fetching Chat Details');
        final _queryList = await _firestore
            .collection('chats')
            .where('problemId', isEqualTo: event.problemId)
            // .where('teacherId', isNotEqualTo: globalUser.id)
            .get();

        final _docList = _queryList.docs
            .where((element) => element['teacherId'] == globalUser.id);

        final _len = _docList.length;
        if (_len == 0) {
          logger.i('New Chat will be created');
          //TODO: implement
          final String _docId =
              FirebaseFirestore.instance.collection('chats').doc().id;
          final DateTime now = DateTime.now();
          final DateTime date = DateTime(now.year, now.month, now.day);
          final ChatModel _chatModel = ChatModel(
            studentId: event.studentId,
            teacherId: globalUser.id,
            problemId: event.problemId,
            chatId: _docId,
            dateCreated: date.toIso8601String(),
            dateUpdated: date.toIso8601String(),
          );
          await ChatFunctions.createChat(chatModel: _chatModel);
          logger.i('New Chat CREATED');
          //TODO: change this
          yield UserHomeChatPage(chatModel: _chatModel);
        } else {
          logger.i('Chat Found');
          //TODO: implement
          Map<String, dynamic> doc;
          // _docList.forEach((element) {
          //   doc = element.data();
          // });
          for (final element in _docList) {
            doc = element.data();
          }
          logger.d(doc.toString());
          yield UserHomeChatPage(chatModel: ChatModel.fromJson(doc));
        }
      }
    } on PlatformException catch (e) {
      yield UserHomeFailure(message: "Error: ${e.message}");
    } on FirebaseAuthException catch (e) {
      yield UserHomeFailure(message: "Error: ${e.message}");
    } on TimeoutException catch (e) {
      yield UserHomeFailure(message: "Error: ${e.message}");
    } catch (e) {
      yield UserHomeFailure(message: "Error: ${e.message}");
    }
  }
}
