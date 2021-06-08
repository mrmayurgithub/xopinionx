import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xopinionx/config/theme/app_themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(appThemeData: appThemeData[AppTheme.kDark]));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // preferences.setInt('theme_id', event.appTheme.index);
      yield ThemeState(appThemeData: appThemeData[event.appTheme]);
    }
  }
}
