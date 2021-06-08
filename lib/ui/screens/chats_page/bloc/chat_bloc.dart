import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/core/api/models/chat_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitialized());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    try {
      // if (event is ChatRequested) {
      //   //TODO: complete
      // }
    } on PlatformException catch (e) {
      yield ChatFailure(message: "Error: ${e.message}");
    } on TimeoutException catch (e) {
      yield ChatFailure(message: "Timeout: ${e.message}");
    } on FirebaseAuthException catch (e) {
      yield ChatFailure(message: "Error: ${e.message}");
    } catch (e) {
      yield ChatFailure(message: e.toString());
    }
  }
}
