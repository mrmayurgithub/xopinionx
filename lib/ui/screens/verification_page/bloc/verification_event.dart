part of 'verification_bloc.dart';

abstract class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class VerificationInitiated extends VerificationEvent {
  final bool isFirstTime;
  const VerificationInitiated({this.isFirstTime = false});

  @override
  List<Object> get props => [];
}

class ResendVerificationMail extends VerificationEvent {}
