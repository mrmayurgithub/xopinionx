import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/api/functions/problem_functions.dart';
import 'package:xopinionx/api/models/problem_model.dart';
import 'package:xopinionx/global/logger.dart';

part 'user_queries_event.dart';
part 'user_queries_state.dart';

class UserQueriesBloc extends Bloc<UserQueriesEvent, UserQueriesState> {
  UserQueriesBloc() : super(UserQueriesInitial());
  @override
  Stream<UserQueriesState> mapEventToState(UserQueriesEvent event) async* {
    try {
      if (event is UserQueriesRequested) {
        yield UserQueriesInProgress();
        // await loadUserProblems();
        yield UserQueriesLoaded();
        // yield UserQueriesSuccess();
      }
      if (event is ChatRequested) {
        //TODO: complete
      }
      if (event is DeleteProblemRequested) {
        //TODO: complete
        logger.i("Deleting porblem");
        ProblemFunctions.deleteProblem(problem: event.problem);
        logger.i("Successfull: Problem Deletion");
        yield ProblemDeleted();
      }
      if (event is EditProblemRequested) {
        //TODO: complete
      }
      if (event is SolveProblem) {
        //TODO: complete
      }
    } on PlatformException catch (e) {
      yield UserQueriesFailure(message: "Error: ${e.message}");
    } on FirebaseAuthException catch (e) {
      yield UserQueriesFailure(message: "Error: ${e.message}");
    } on TimeoutException catch (e) {
      yield UserQueriesFailure(message: "Timeout: ${e.message}");
    } catch (e) {
      yield UserQueriesFailure(message: e.toString());
    }
  }
}
