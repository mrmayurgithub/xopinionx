import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/api/functions/user_functions.dart';
import 'package:xopinionx/api/models/user_model.dart';
import 'package:xopinionx/global/enums.dart';
import 'package:xopinionx/global/global_helpers.dart';

part 'settings_state.dart';
part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    try {
      if (event is SaveButtonPressed) {
        yield SettingsInProgress();
        await UserFunctions.updateUserDetails(
          UserModel(
            id: globalUser.id,
            fname: event.fname,
            lname: event.lname,
            schoolORCollege: event.educationLevel,
            eduYear: event.eduYear,
            languagePreferences: event.langpref,
            userTags: event.usertags,
            email: globalUser.email,
            registrationStatus: globalUser.registrationStatus,
            sessionBalance: globalUser.sessionBalance,
            overallReview: globalUser.overallReview,
          ),
        );
        yield SettingsSaved();
      }
      if (event is CancelButtonPressed) {
        yield SettingsCancelled();
      }
      if (event is EditButtonPressed) {
        yield EditableSettingsPage();
      }
    } on PlatformException catch (e) {
      yield SettingsFailure(message: "Error: ${e.message}");
    } on FirebaseAuthException catch (e) {
      yield SettingsFailure(message: "Error: ${e.message}");
    } on TimeoutException catch (e) {
      yield SettingsFailure(message: "Timeout: ${e.message}");
    } catch (e) {
      yield SettingsFailure(message: e.toString());
    }
  }
}
