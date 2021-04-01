part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChangeChat extends ChatEvent {}

class ChatListRequested extends ChatEvent {}
