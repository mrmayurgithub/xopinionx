part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsInProgress extends SettingsState {}

class SettingsPageLoaded extends SettingsState {}

class EditableSettingsPage extends SettingsState {}

class SettingsCancelled extends SettingsState {}

class SettingsSaved extends SettingsState {}

class SettingsFailure extends SettingsState {
  final String message;

  SettingsFailure({this.message});
  @override
  List<Object> get props => [message];
}
