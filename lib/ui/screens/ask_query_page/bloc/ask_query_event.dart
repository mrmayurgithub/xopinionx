part of 'ask_query_bloc.dart';

abstract class AskQueryEvent extends Equatable {
  const AskQueryEvent();
  @override
  List<Object> get props => [];
}

class QuerySubmitButtonPressed extends AskQueryEvent {
  final String problem;
  final String description;
  final Tags tag;

  const QuerySubmitButtonPressed({
    @required this.problem,
    @required this.description,
    @required this.tag,
  });
}

class QueryCancelButtonPressed extends AskQueryEvent {}
