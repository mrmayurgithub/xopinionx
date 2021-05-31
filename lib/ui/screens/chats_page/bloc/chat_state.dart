part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitialized extends ChatState {}

class NoChatSelected extends ChatState {}

class ChatSelected extends ChatState {}

class ChatInProgress extends ChatState {}

// class ChatStarted extends ChatState {}

class ChatFailure extends ChatState {
  final String message;

  ChatFailure({this.message});

  @override
  List<Object> get props => [message];
}
