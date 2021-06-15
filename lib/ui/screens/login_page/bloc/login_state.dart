part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginNeedsVerification extends LoginState {}

class LoginFailure extends LoginState {
  final String message;
  const LoginFailure({this.message});

  @override
  List<Object> get props => [message];
}
