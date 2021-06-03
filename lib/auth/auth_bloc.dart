import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/utils/status.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthUnInitialized());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is AppStarted) {
        yield AuthInProgress();
        // final _currentUser = FirebaseAuth.instance.currentUser;
        // if (_currentUser != null) {
        //   logger.i('Checking whether user is verified');
        //   if (_currentUser.emailVerified) {
        //     logger.i('Checking whether profile is Complete');
        //     // final _querySnapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: _currentUser.email).get();

        //     // final _doc = _querySnapshot.docs;
        //     // if (_doc.length == 0) {
        //     //   logger.i('Profile is incomplete');
        //     //   yield AuthNeedsProfileComplete();
        //     // }
        //     // else {
        //     logger.i('All Checks Completed');
        //     logger.i('Initializing API');
        //     await initializeApi;
        //     logger.i('API Initialized');
        //     yield AuthAuthenticated();
        //     // }
        //   } else {
        //     yield AuthNeedsVerification();
        //   }
        // } else {
        //   yield AuthUnAuthenticated();
        // }

        if (UserLoginStatus().isLoggedIn()) {
          logger.i('Checking whether user is verified');
          final _currentUser = FirebaseAuth.instance.currentUser;
          if (_currentUser.emailVerified) {
            logger.i('Checking whether profile is Complete');
            logger.i('All Checks Completed');
            logger.i('Initializing API');
            await initializeApi;
            logger.i('API Initialized');
            yield AuthAuthenticated();
          } else {
            yield AuthNeedsVerification();
          }
        } else {
          yield const AuthUnAuthenticated();
        }
      } else if (event is JustLoggedOut) {
        yield AuthInProgress();
        await FirebaseAuth.instance.signOut();
        await GoogleSignIn().signOut();
        await disposeApi;
        yield const AuthUnAuthenticated(justLoggedOut: true);
      }
    } on PlatformException catch (e) {
      yield AuthFailure(message: "Error: ${e.message}");
    } on TimeoutException catch (e) {
      yield AuthFailure(message: "Timeout: ${e.message}");
    } on FirebaseAuthException catch (e) {
      yield AuthFailure(message: "Error: ${e.message}");
    } catch (e) {
      yield AuthFailure(message: e.toString());
    }
  }
}
