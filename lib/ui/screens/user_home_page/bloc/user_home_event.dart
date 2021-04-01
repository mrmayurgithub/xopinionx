part of 'user_home_bloc.dart';

abstract class UserHomeEvent extends Equatable {
  const UserHomeEvent();

  @override
  List<Object> get props => [];
}

class UserHomeReviewsRequested extends UserHomeEvent {}

class UserHomeHistoryRequested extends UserHomeEvent {}

class UserHomeLogoutRequested extends UserHomeEvent {}

class UserHomeBlogRequested extends UserHomeEvent {}

class UserHomeDonateRequested extends UserHomeEvent {}

class UserHomeAskQueryRequested extends UserHomeEvent {}

class UserHomeChatRequested extends UserHomeEvent {
  final String chatUserId;

  UserHomeChatRequested({this.chatUserId});

  @override
  List<Object> get props => [chatUserId];
}
