import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:xopinionx/core/auth/functions/signIn.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try {
      if (event is LoginButtonPressed) {
        yield LoginInProgress();
        await signInWithEmailAndPass(
            email: event.email, password: event.password);

        logger.i('Checking weather user email is verified');
        final _currentUser = FirebaseAuth.instance.currentUser;

        if (_currentUser.emailVerified) {
          logger.i('Initializing API');
          yield LoginInProgress();
          await initializeApi;
          logger.i("API Initialized");
          yield LoginSuccess();
        } else {
          yield LoginNeedsVerification();
        }
      } else if (event is LoginWithGoogle) {
        yield LoginInProgress();

        final _googleSignIn = GoogleSignIn();
        final _googleSigninAccount = await _googleSignIn.signIn();
        final _googleAuth = await _googleSigninAccount.authentication;
        final _authCredentials = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken,
          accessToken: _googleAuth.accessToken,
        );
        await FirebaseAuth.instance.signInWithCredential(_authCredentials);

        logger.i("All Checks Passed");

        logger.i("Initializing API");
        await initializeApi;
        yield LoginSuccess();
      }
    } on PlatformException catch (e) {
      yield LoginFailure(message: "Error: ${e.message}");
    } on FirebaseAuthException catch (e) {
      yield LoginFailure(message: "Error: ${e.message}");
    } on TimeoutException catch (e) {
      yield LoginFailure(message: "Timeout: ${e.message}");
    } catch (e) {
      yield LoginFailure(message: e.toString());
    }
  }
}
