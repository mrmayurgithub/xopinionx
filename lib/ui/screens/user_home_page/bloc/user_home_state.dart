part of 'user_home_bloc.dart';

abstract class UserHomeState extends Equatable {
  const UserHomeState();

  @override
  List<Object> get props => [];
}

class UserHomeIntial extends UserHomeState {}

class UserHomeInProgress extends UserHomeState {}

class UserHomeSuccess extends UserHomeState {}

class UserHomeFailure extends UserHomeState {
  final String message;

  UserHomeFailure({@required this.message});
  @override
  List<Object> get props => [message];
}
