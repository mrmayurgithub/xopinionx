part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
  @override
  List<Object> get props => [];
}

class LoginPageRequested extends HomePageEvent {}

class SignUpPageRequested extends HomePageEvent {}

class BlogPageRequested extends HomePageEvent {}

class DonationPageRequested extends HomePageEvent {}
