import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';
part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    try {
      if (event is SaveButtonPressed) {
        //TODO: complete
      }
      if (event is CancelButtonPressed) {
        //TODO: complete
      }
    } on PlatformException catch (e) {
      yield (SettingsFailure(message: "Error: ${e.message}"));
    } on FirebaseAuthException catch (e) {
      yield (SettingsFailure(message: "Error: ${e.message}"));
    } on TimeoutException catch (e) {
      yield (SettingsFailure(message: "Timeout: ${e.message}"));
    } catch (e) {
      yield (SettingsFailure(message: e.toString()));
    }
  }
}
