part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonClicked extends RegisterEvent {
  final String email;
  final String password;
  final String educationLevel;
  final int eduYear;
  final String langpref;
  RegisterButtonClicked({
    @required this.educationLevel,
    @required this.eduYear,
    @required this.langpref,
    @required this.email,
    @required this.password,
  })  : assert(email != null),
        assert(password != null);

  @override
  List<Object> get props => [email, password];
}

class GoogleSignUpClicked extends RegisterEvent {}
