part of 'ask_query_bloc.dart';

abstract class AskQueryState extends Equatable {
  const AskQueryState();
  @override
  List<Object> get props => [];
}

class AskQueryInitial extends AskQueryState {}

class AskQueryInProgress extends AskQueryState {}

class AskQueryPostedSuccess extends AskQueryState {}

class AskQueryCancelled extends AskQueryState {}

class AskQueryFailure extends AskQueryState {
  final String message;

  AskQueryFailure({@required this.message});
  @override
  List<Object> get props => [message];
}
