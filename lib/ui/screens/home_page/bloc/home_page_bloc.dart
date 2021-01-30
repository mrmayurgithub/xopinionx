import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:xopinionx/global/logger.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial());

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    try {
      if (event is LoginPageRequested) {
        logger.i('LoginPage Requested');
        yield LoginPageLoaded();
      }
      if (event is SignUpPageRequested) {
        logger.i('SignUpPage Requested');
        yield SignUpPageLoaded();
      }
      if (event is BlogPageRequested) {
        logger.i('BlogPage Requested');
        yield BlogPageLoaded();
        //TODO: Write blogs and call a query from here
      }
      if (event is DonationPageRequested) {
        logger.i('DonationPage Requested');
        yield DonationPageLoaded();
      }
    } on PlatformException catch (e) {
      yield (HomePageFailure(message: "Error: ${e.message}"));
    } on FirebaseAuthException catch (e) {
      yield (HomePageFailure(message: "Error: ${e.message}"));
    } on TimeoutException catch (e) {
      yield (HomePageFailure(message: "Error: ${e.message}"));
    } catch (e) {
      yield (HomePageFailure(message: "Error: ${e.message}"));
    }
  }
}
