part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class ChatButtonPressed extends HistoryEvent {
  final ProblemModel problemModel;

  const ChatButtonPressed({@required this.problemModel});
  @override
  List<Object> get props => [problemModel];
}

class UserHistoryRequested extends HistoryEvent {}
