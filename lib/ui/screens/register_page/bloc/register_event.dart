part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonClicked extends RegisterEvent {
  final String fname;
  final String lname;
  final String email;
  final String password;
  final String educationLevel;
  final int eduYear;
  final String langpref;
  final List<Tags> usertags;
  const RegisterButtonClicked({
    @required this.fname,
    @required this.lname,
    @required this.educationLevel,
    @required this.eduYear,
    @required this.langpref,
    @required this.email,
    @required this.password,
    @required this.usertags,
  })  : assert(email != null),
        assert(password != null);

  @override
  List<Object> get props => [
        email,
        password,
        fname,
        lname,
        educationLevel,
        eduYear,
        langpref,
        usertags
      ];
}

class GoogleSignUpClicked extends RegisterEvent {}
