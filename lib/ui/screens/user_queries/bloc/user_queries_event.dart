part of 'user_queries_bloc.dart';

abstract class UserQueriesEvent extends Equatable {
  const UserQueriesEvent();

  @override
  List<Object> get props => [];
}

class ChatRequested extends UserQueriesEvent {
  final ProblemModel problem;

  const ChatRequested({this.problem});

  @override
  List<Object> get props => [problem];
}

class DeleteProblemRequested extends UserQueriesEvent {
  final ProblemModel problem;

  const DeleteProblemRequested({this.problem});

  @override
  List<Object> get props => [problem];
}

class EditProblemRequested extends UserQueriesEvent {
  final ProblemModel problem;

  const EditProblemRequested({this.problem});

  @override
  List<Object> get props => [problem];
}

class SolveProblem extends UserQueriesEvent {
  final ProblemModel problem;

  const SolveProblem({this.problem});

  @override
  List<Object> get props => [problem];
}

class UserQueriesRequested extends UserQueriesEvent {}
