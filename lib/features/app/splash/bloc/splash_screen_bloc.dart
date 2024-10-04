import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial()) {
    on<getUID>((event, emit) async {
      emit(SplashScreenLoading());
      // if (uid == null) {
      //   emit(SplashScreenError());
      // } else {
      //   emit(SplashScreenLoaded());
      // }
    });
  }
}
