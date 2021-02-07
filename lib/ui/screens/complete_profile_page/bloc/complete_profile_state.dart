part of 'complete_profile_bloc.dart';

abstract class CompleteProfileState extends Equatable {
  const CompleteProfileState();
  @override
  List<Object> get props => [];
}

class CompleteProfileInitial extends CompleteProfileState {}

class CompleteProfileInProgress extends CompleteProfileState {}

class CompleteProfileSuccess extends CompleteProfileState {}

class CompleteProfileFailed extends CompleteProfileState {
  final String message;
  CompleteProfileFailed({this.message});

  @override
  List<Object> get props => [message];
}
