import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/api/functions/problem_functions.dart';
import 'package:xopinionx/api/models/problem_model.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/global/logger.dart';

part 'ask_query_state.dart';
part 'ask_query_event.dart';

class AskQueryBloc extends Bloc<AskQueryEvent, AskQueryState> {
  AskQueryBloc() : super(AskQueryInitial());

  @override
  Stream<AskQueryState> mapEventToState(AskQueryEvent event) async* {
    try {
      if (event is QuerySubmitButtonPressed) {
        yield AskQueryInProgress();
        logger.i('Submitting Problem');
        DateTime now = DateTime.now();
        DateTime date = DateTime(now.year, now.month, now.day);
        // var parsedDate = DateTime.parse('1974-03-20 00:00:00.000');
        // final _currentUser = FirebaseAuth.instance.currentUser;

        await ProblemFunctions.createProblem(
          problem: ProblemModel(
            userId: globalUser.id,
            problemDescription: event.description,
            datePosted: date.toString(),
            problemTitle: event.problem,
            status: false,
            tag: event.tag,
          ),
        );
        logger.i('Problem Submitted');
        yield AskQueryPostedSuccess();
      }
      if (event is QueryCancelButtonPressed) {
        logger.i('Succesffuly Cancelled');
        yield AskQueryCancelled();
      }
    } on PlatformException catch (e) {
      yield (AskQueryFailure(message: "Error: ${e.message}"));
    } on FirebaseAuthException catch (e) {
      yield (AskQueryFailure(message: "Error: ${e.message}"));
    } on TimeoutException catch (e) {
      yield (AskQueryFailure(message: "Timeout: ${e.message}"));
    } catch (e) {
      yield (AskQueryFailure(message: e.toString()));
    }
  }
}
