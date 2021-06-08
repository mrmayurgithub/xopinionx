import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/core/api/models/problem_model.dart';
import 'package:xopinionx/global/logger.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial());

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    try {
      if (event is ChatButtonPressed) {
        //TODO: get problemchats
      }
      if (event is UserHistoryRequested) {
        yield HistoryInProgress();
        logger.v("Collecting user history");
        yield HistorySuccess();
      }
    } on PlatformException catch (e) {
      yield HistoryFailure(message: "Error: ${e.message}");
    } on FirebaseAuthException catch (e) {
      yield HistoryFailure(message: "Error: ${e.message}");
    } on TimeoutException catch (e) {
      yield HistoryFailure(message: "Timeout: ${e.message}");
    } catch (e) {
      yield HistoryFailure(message: e.toString());
    }
  }
}
