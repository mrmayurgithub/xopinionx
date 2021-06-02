part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInProgress extends HistoryState {}

class HistoryInitial extends HistoryState {}

class HistorySuccess extends HistoryState {}

class HistoryFailure extends Equatable {
  final String message;

  HistoryFailure({this.message});
  @override
  List<Object> get props => [message];
}
