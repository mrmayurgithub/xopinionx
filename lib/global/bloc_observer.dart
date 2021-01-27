import 'package:bloc/bloc.dart';
import 'package:xopinionx/global/logger.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    logger.i(event);
    super.onEvent(bloc, event);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    //TODO: Check if above parameter CUBIT is correct
    logger.e(error);
    super.onError(cubit, error, stackTrace);
  }
  //  @override
  // void onError(Bloc bloc, Object error, StackTrace stacktrace) {
  //   logger.e(error);
  //   super.onError(bloc, error, stacktrace);
  // }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    logger.i(transition);
    super.onTransition(bloc, transition);
  }
}
