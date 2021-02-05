import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:xopinionx/auth/functions/signIn.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';
import 'package:xopinionx/api/models/user_model.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try {
      if (event is LoginButtonPressed) {
        yield LoginInProgress();
        await signInWithEmailAndPass(email: event.email, password: event.password);
        await FirebaseAnalytics().logLogin(loginMethod: 'email_pass');
        logger.i('Checking weather user email is verified');
        final _currentUser = FirebaseAuth.instance.currentUser;

        if (_currentUser.emailVerified) {
          logger.i('Initializing API');
          await initializeApi;
          logger.i("API Initialized");
          logger.i("Checking whether profile is complete");
          if (globalUser.registrationStatus != "${registrationStatus.registered}") {
            logger.i('User Profile Incomplete');
            yield LoginNeedsProfileComplete();
          } else {
            logger.i('All Checks Passed');
            yield LoginSuccess();
          }
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
        await FirebaseAnalytics().logLogin(loginMethod: "google_signin");

        final _currentUser = FirebaseAuth.instance.currentUser;
        logger.i("Checking Whether Profile is Complete");

        final _querySnapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: _currentUser.email).get();

        final _doc = _querySnapshot.docs;

        if (_doc.length == 0) {
          logger.i("User Profile Incomplete");

          yield (LoginNeedsProfileComplete());
        } else {
          logger.i("All Checks Passed");

          logger.i("Initializing API");
          await initializeApi;
          yield (LoginSuccess());
        }
      } else if (event is ForgetPassword) {
        yield LoginInProgress();
        await FirebaseAuth.instance.sendPasswordResetEmail(email: event.email);
        logger.i('Password reset email sent');
        yield ForgetPasswordSuccess();
      }
    } on PlatformException catch (e) {
      yield (LoginFailure(message: "Error: ${e.message}"));
    } on FirebaseAuthException catch (e) {
      yield (LoginFailure(message: "Error: ${e.message}"));
    } on TimeoutException catch (e) {
      yield (LoginFailure(message: "Timeout: ${e.message}"));
    } catch (e) {
      yield (LoginFailure(message: e.toString()));
    }
  }
}