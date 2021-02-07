import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/ui/screens/complete_profile_page/complete_profile.dart';

part 'complete_profile_state.dart';
part 'complete_profile_event.dart';

class CompleteProfileBloc extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  CompleteProfileBloc() : super(CompleteProfileInitial());

  @override
  Stream<CompleteProfileState> mapEventToState(CompleteProfileEvent event) async* {
    try {
      if (event is SubmitProfileButtonClicked) {}
    } on PlatformException catch (e) {
      yield (CompleteProfileFailed(message: "Error: ${e.message}"));
    } on FirebaseAuthException catch (e) {
      yield (CompleteProfileFailed(message: "Error: ${e.message}"));
    } on TimeoutException catch (e) {
      yield (CompleteProfileFailed(message: "Timeout: ${e.message}"));
    } catch (e) {
      yield (CompleteProfileFailed(message: e.toString()));
    }
  }
}
