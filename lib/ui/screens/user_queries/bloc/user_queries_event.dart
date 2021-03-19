part of 'user_queries_bloc.dart';

abstract class UserQueriesEvent extends Equatable {
  const UserQueriesEvent();

  @override
  List<Object> get props => [];
}

class ChatRequested extends UserQueriesEvent {
  final ProblemModel problem;

  ChatRequested({this.problem});

  @override
  List<Object> get props => [problem];
}

class DeleteProblemRequested extends UserQueriesEvent {
  final ProblemModel problem;

  DeleteProblemRequested({this.problem});

  @override
  List<Object> get props => [problem];
}

class EditProblemRequested extends UserQueriesEvent {
  final ProblemModel problem;

  EditProblemRequested({this.problem});

  @override
  List<Object> get props => [problem];
}

class SolveProblem extends UserQueriesEvent {
  final ProblemModel problem;

  SolveProblem({this.problem});

  @override
  List<Object> get props => [problem];
}

class UserQueriesRequested extends UserQueriesEvent {}
