part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageLoaded extends HomePageState {}

class HomePageProgress extends HomePageState {}

class BlogPageLoaded extends HomePageState {}

class LoginPageLoaded extends HomePageState {}

class SignUpPageLoaded extends HomePageState {}

class DonationPageLoaded extends HomePageState {}

class HomePageFailure extends HomePageState {
  final String message;
  const HomePageFailure({this.message});

  @override
  List<Object> get props => [message];
}
