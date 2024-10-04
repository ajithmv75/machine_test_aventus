import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../app_exceptions/failures/auth_failures.dart';
import '../../../../../../signin/domain/use_cases/google_signin_usecase.dart';
part 'google_signin_event.dart';
part 'google_signin_state.dart';

class GoogleSigninBloc extends Bloc<GoogleSigninEvent, GoogleSigninState> {
  final GoogleSignInUseCase _googleSignInUseCase;
  GoogleSigninBloc(this._googleSignInUseCase) : super(GoogleSigninInitial()) {
    on<GoogleSigninEvent>((event, emit) async {
      emit(GoogleSigninLoading());
      final user = await _googleSignInUseCase();

      return user.fold((failure) => emit(GoogleSignFailure(failure)),
              (success) => emit(GoogleSigninSuccess()));
    });
  }
}
