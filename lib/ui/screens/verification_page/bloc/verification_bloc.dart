import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:xopinionx/global/logger.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(VerificationInitial());

  @override
  Stream<VerificationState> mapEventToState(
    VerificationEvent event,
  ) async* {
    try {
      if (event is VerificationInitiated) {
        yield VerificationInProgress();
        logger.wtf('Verification Started');
        final _user = FirebaseAuth.instance.currentUser;
        await _user.reload();
        final bool _isEmailVerified = _user.emailVerified;
        logger.wtf("Email Verified: $_isEmailVerified");
        if (_isEmailVerified) {
          yield VerificationSuccess();
        } else if (event.isFirstTime) {
          yield VerificationFailed(
            message: "Click on the link sent to verify your email id",
          );
        } else {
          yield VerificationFailed(
            message:
                "Verification Failed. Please Click on the link sent to your email id",
          );
        }
      } else if (event is ResendVerificationMail) {
        yield VerificationInProgress();
        final _user = FirebaseAuth.instance.currentUser;
        await _user.sendEmailVerification();
        yield ResendVerification();
      }
    } on PlatformException catch (e) {
      yield VerificationFailed(message: "Error: ${e.message}");
    } on TimeoutException catch (e) {
      yield VerificationFailed(message: "Timeout: ${e.message}");
    } catch (e) {
      yield VerificationFailed(message: e.toString());
    }
  }
}
