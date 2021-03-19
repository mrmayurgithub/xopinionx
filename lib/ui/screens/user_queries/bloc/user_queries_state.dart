part of 'user_queries_bloc.dart';

abstract class UserQueriesState extends Equatable {
  const UserQueriesState();

  @override
  List<Object> get props => [];
}

class UserQueriesInitial extends UserQueriesState {}

class UserQueriesInProgress extends UserQueriesState {}

class UserQueriesSuccess extends UserQueriesState {}

class ProblemChatLoaded extends UserQueriesState {
  //TODO: Complete
}

class ProblemDeleted extends UserQueriesState {}

class ProblemEdited extends UserQueriesState {}

class ProblemSolved extends UserQueriesState {}

class UserQueriesFailure extends UserQueriesState {
  final String message;

  UserQueriesFailure({this.message});

  @override
  List<Object> get props => [message];
}

class UserQueriesLoaded extends UserQueriesState {
  @override
  List<Object> get props => [];
}
