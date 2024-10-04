import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:machine_test/features/signin/presentation/bloc/signin_event.dart';
import 'package:machine_test/features/signin/presentation/bloc/signin_state.dart';

import '../../../../core/utils/validations.dart';
import '../../domain/use_cases/signin_usecase.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final SigninUseCase _signinUseCase;

  SigninBloc(this._signinUseCase) : super(SigninState.initial()) {
    on<EmailChangedSignin>(_emailChanged);
    on<PasswordChangedSignin>(_passwordChanged);
    on<SigninFormSubmittedSignin>(signinFormSubmitted);
  }

  void _emailChanged(EmailChangedSignin event, Emitter<SigninState> emit) {
    emit(state.copyWith(
      email: event.email,
      formSubmittedSuccessfully: false,
      failure: none(),
    ));
  }

  void _passwordChanged(
      PasswordChangedSignin event, Emitter<SigninState> emit) {
    emit(state.copyWith(
      password: event.password,
      formSubmittedSuccessfully: false,
      failure: none(),
    ));
  }

  void signinFormSubmitted(
      SigninFormSubmittedSignin event, Emitter<SigninState> emit) async {
    final email = isValidEmail(state.email);
    final password = isPasswordValid(state.password);
    //value is null then it is valid
    if (email == null && password == null) {
      emit(state.copyWith(isLoading: true));
      final user = await _signinUseCase(state.email, state.password);

      return user.fold(
        (failure) => emit(
          state.copyWith(
              formSubmittedSuccessfully: false,
              isLoading: false,
              showErrorMessage: false,
              failure: some(failure)),
        ),
        (success) => emit(
          state.copyWith(
            formSubmittedSuccessfully: true,
            isLoading: false,
            showErrorMessage: false,
            failure: none(),
          ),
        ),
      );
    }

    emit(state.copyWith(showErrorMessage: true));
  }
}
