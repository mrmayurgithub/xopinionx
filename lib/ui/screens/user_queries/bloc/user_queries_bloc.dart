import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/api/models/problem_model.dart';

part 'user_queries_event.dart';
part 'user_queries_state.dart';

class UserQueriesBloc extends Bloc<UserQueriesEvent, UserQueriesState> {
  UserQueriesBloc() : super(UserQueriesInitial());
  @override
  Stream<UserQueriesState> mapEventToState(UserQueriesEvent event) async* {
    try {
      if (event is ChatRequested) {
        //TODO: complete
      }
      if (event is DeleteProblemRequested) {
        //TODO: complete
      }
      if (event is EditProblemRequested) {
        //TODO: complete
      }
      if (event is SolveProblem) {
        //TODO: complete
      }
    } on PlatformException catch (e) {
      yield (UserQueriesFailure(message: "Error: ${e.message}"));
    } on FirebaseAuthException catch (e) {
      yield (UserQueriesFailure(message: "Error: ${e.message}"));
    } on TimeoutException catch (e) {
      yield (UserQueriesFailure(message: "Timeout: ${e.message}"));
    } catch (e) {
      yield (UserQueriesFailure(message: e.toString()));
    }
  }
}
