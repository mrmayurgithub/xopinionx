import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/global/logger.dart';
part 'forgot_p_state.dart';
part 'forgot_p_event.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitialState());

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    try {
      if (event is ForgotPasswordRequested) {
        yield ForgotPasswordLoading();
        await FirebaseAuth.instance.sendPasswordResetEmail(email: event.email);
        logger.i('Password reset email sent');
        yield ForgotPasswordSuccess();
      }
    } on PlatformException catch (e) {
      yield ForgotPasswordFailure(message: "Error: ${e.message}");
    } on FirebaseAuthException catch (e) {
      yield ForgotPasswordFailure(message: "Error: ${e.message}");
    } on TimeoutException catch (e) {
      yield ForgotPasswordFailure(message: "Timeout: ${e.message}");
    } catch (e) {
      yield ForgotPasswordFailure(message: e.toString());
    }
  }
}
