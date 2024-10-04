import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:machine_test/features/signup/presentation/bloc/signup_event.dart';
import 'package:machine_test/features/signup/presentation/bloc/signup_state.dart';

import '../../../../core/utils/validations.dart';
import '../../domain/use_cases/signup_usecase.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUseCase _signupUseCase;

  SignupBloc(this._signupUseCase) : super(SignupState.initial()) {
    on<EmailChangedSignup>(_emailChanged);
    on<PasswordChangedSignup>(_passwordChanged);
    on<SignupFormSubmittedSignup>(_signupFormSubmitted);
  }

  void _emailChanged(EmailChangedSignup event, Emitter<SignupState> emit) {
    emit(state.copyWith(
        email: event.email, formSubmittedSuccessfully: false, failure: none()));
  }

  void _passwordChanged(
      PasswordChangedSignup event, Emitter<SignupState> emit) {
    emit(
      state.copyWith(
        password: event.password,
        formSubmittedSuccessfully: false,
        failure: none(),
      ),
    );
  }

  void _signupFormSubmitted(SignupFormSubmittedSignup event, Emitter<SignupState> emit) async {
    final email = isValidEmail(state.email);
    final password = isPasswordValid(state.password);
    if (email == null && password == null) {
      emit(state.copyWith(isLoading: true));
      final user = await _signupUseCase(state.email, state.password);
      user.fold(
              (failure) => emit(state.copyWith(
              formSubmittedSuccessfully: false,
              isLoading: false,
              showErrorMessage: false,
              failure: some(failure))),
              (success) => emit(state.copyWith(
              formSubmittedSuccessfully: true,
              isLoading: false,
              showErrorMessage: false)));
    }

    emit(state.copyWith(showErrorMessage: true));
  }
}
