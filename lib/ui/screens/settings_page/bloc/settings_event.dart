part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class EditButtonPressed extends SettingsEvent {}

class SaveButtonPressed extends SettingsEvent {
  final String fname;
  final String lname;
  final String educationLevel;
  final int eduYear;
  final String langpref;
  final List<Tags> usertags;
  SaveButtonPressed({
    @required this.fname,
    @required this.lname,
    @required this.educationLevel,
    @required this.eduYear,
    @required this.langpref,
    @required this.usertags,
  })  : assert(fname != null),
        assert(lname != null);
  @override
  List<Object> get props => [fname, lname, educationLevel, eduYear, langpref, usertags];
}

class CancelButtonPressed extends SettingsEvent {}
