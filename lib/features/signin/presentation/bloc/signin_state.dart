// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import '../../../../app_exceptions/failures/auth_failures.dart';


class SigninState {
  final String email;
  final String password;
  final bool formSubmittedSuccessfully;
  final bool isLoading;
  final bool showErrorMessage;
  final Option<AuthFailures> failure;

  SigninState({
    required this.showErrorMessage,
    required this.email,
    required this.password,
    required this.formSubmittedSuccessfully,
    required this.isLoading,
    required this.failure,
  });

  SigninState copyWith({
    String? email,
    String? password,
    bool? formSubmittedSuccessfully,
    bool? isLoading,
    bool? showErrorMessage,
    Option<AuthFailures>? failure,
  }) {
    return SigninState(
      email: email ?? this.email,
      password: password ?? this.password,
      formSubmittedSuccessfully:
          formSubmittedSuccessfully ?? this.formSubmittedSuccessfully,
      isLoading: isLoading ?? this.isLoading,
      showErrorMessage: showErrorMessage ?? this.showErrorMessage,
      failure: failure ?? this.failure,
    );
  }

  factory SigninState.initial() => SigninState(
        showErrorMessage: false,
        email: '',
        password: '',
        formSubmittedSuccessfully: false,
        isLoading: false,
        failure: none(),
      );
}
