import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:xopinionx/api/functions/user_functions.dart';
import 'package:xopinionx/api/models/user_model.dart';
import 'package:xopinionx/auth/functions/signUp.dart';
import 'package:xopinionx/global/logger.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    try {
      if (event is RegisterButtonClicked) {
        yield (RegisterInProgress());
        await signUpWithEmailAndPass(email: event.email, password: event.password);
        logger.i('Signup successfull');
        await UserFunctions.createUser(
          UserModel(
            fname: event.fname,
            lname: event.lname,
            email: event.email,
            sessionBalance: 2,
            schoolORCollege: event.educationLevel,
            eduYear: event.eduYear,
            overallReview: 0,
            languagePreferences: event.langpref,
            registrationStatus: registrationStatus.registered.toString(),
          ),
        );
        logger.i('User created successfully');
        await FirebaseAnalytics().logSignUp(signUpMethod: "email_pass");
        yield (RegisterSuccess());
      } else if (event is GoogleSignUpClicked) {
        yield (RegisterInProgress());
        final _googleSignIn = GoogleSignIn();
        final GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
        final AuthCredential _authCredentials = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken,
          accessToken: _googleAuth.accessToken,
        );

        await FirebaseAuth.instance.signInWithCredential(_authCredentials);
        await FirebaseAnalytics().logSignUp(signUpMethod: "google_signup");

        yield (RegisterSuccess());
      }
    } on PlatformException catch (e) {
      yield (RegisterFailed(message: "Error: ${e.message}"));
    } on FirebaseAuthException catch (e) {
      yield (RegisterFailed(message: "Error: ${e.message}"));
    } on TimeoutException catch (e) {
      yield (RegisterFailed(message: "Timeout: ${e.message}"));
    } catch (e) {
      yield (RegisterFailed(message: e.toString()));
    }
  }
}
