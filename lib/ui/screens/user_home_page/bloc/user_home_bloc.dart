import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      if (event is UserHomeBlogRequested) {}
      if (event is UserHomeDonateRequested) {}
      if (event is UserHomeAskQueryRequested) {
        logger.i('Ask Query Loaded');
        yield AskQueryLoaded();
      }
    } on PlatformException catch (e) {
      yield (UserHomeFailure(message: "Error: ${e.message}"));
    } on FirebaseAuthException catch (e) {
      yield (UserHomeFailure(message: "Error: ${e.message}"));
    } on TimeoutException catch (e) {
      yield (UserHomeFailure(message: "Error: ${e.message}"));
    } catch (e) {
      yield (UserHomeFailure(message: "Error: ${e.message}"));
    }
  }
}
