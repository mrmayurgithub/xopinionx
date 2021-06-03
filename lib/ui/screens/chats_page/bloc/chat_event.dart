part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetChat extends ChatEvent {
  final ChatModel chatModel;

  const GetChat({@required this.chatModel});
  @override
  List<Object> get props => [chatModel];
}

class ChatListRequested extends ChatEvent {}

class GiveReview extends ChatEvent {
  final ChatModel chatModel;
  const GiveReview({@required this.chatModel});
  @override
  List<Object> get props => [chatModel];
}
