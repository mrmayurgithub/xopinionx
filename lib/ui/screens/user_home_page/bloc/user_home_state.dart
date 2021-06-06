part of 'user_home_bloc.dart';

abstract class UserHomeState extends Equatable {
  const UserHomeState();

  @override
  List<Object> get props => [];
}

class UserHomeIntial extends UserHomeState {}

class UserHomeInProgress extends UserHomeState {}

class QueryNotAllowed extends UserHomeState {}

// class UserHomeSuccess extends UserHomeState {}

class UserHomeLoaded extends UserHomeState {}

class UserHomeChatPage extends UserHomeState {
  final ChatModel chatModel;
  const UserHomeChatPage({@required this.chatModel});
  @override
  List<Object> get props => [chatModel];
}

class AskQueryLoaded extends UserHomeState {}

class UserHomeFailure extends UserHomeState {
  final String message;

  const UserHomeFailure({@required this.message});
  @override
  List<Object> get props => [message];
}
