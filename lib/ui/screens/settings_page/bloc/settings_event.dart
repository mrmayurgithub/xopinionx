part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class EditButtonPressed extends SettingsEvent {}

class SaveButtonPressed extends SettingsEvent {
  //TODO: complete
}

class CancelButtonPressed extends SettingsEvent {}
