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

class GlobalProblemsRequested extends UserHomeEvent {}

class UserHomeChatRequested extends UserHomeEvent {
  final String studentId;
  final String problemId;

  const UserHomeChatRequested({this.studentId, this.problemId});

  @override
  List<Object> get props => [studentId, problemId];
}
