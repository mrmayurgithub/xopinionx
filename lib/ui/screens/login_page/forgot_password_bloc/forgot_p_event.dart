part of 'forgot_p_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordRequested extends ForgotPasswordEvent {
  final String email;
  const ForgotPasswordRequested({this.email});

  @override
  List<Object> get props => [email];
}
