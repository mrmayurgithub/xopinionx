import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xopinionx/api/models/problem_model.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial());

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) {
    try {
      if (event is ChatButtonPressed) {
        //TODO: get problemchats
      }
    } catch (e) {}
  }
}
