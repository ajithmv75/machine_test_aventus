
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/auth_check_usecase.dart';
import '../../domain/use_cases/signout_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignOutUseCase _signOutUseCase;
  final AuthCheckUseCase _authCheckUseCase;
  AuthBloc(this._signOutUseCase, this._authCheckUseCase)
      : super(AuthInitial()) {
    on<AuthSignoutButtonClicked>((event, emit) async {
      await _signOutUseCase();
      emit(Unauthenticated());
    });
    on<AuthCheckEvent>((event, emit) {
      final user = _authCheckUseCase();
///if user data is null, then the user is not authenticated
      if (user != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
