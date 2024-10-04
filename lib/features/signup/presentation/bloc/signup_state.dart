// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import '../../../../app_exceptions/failures/auth_failures.dart';

class SignupState {
  final String email;
  final String password;
  final bool formSubmittedSuccessfully;
  final bool isLoading;
  final bool showErrorMessage;
  final Option<AuthFailures> failure;

  SignupState({
    required this.email,
    required this.password,
    required this.formSubmittedSuccessfully,
    required this.isLoading,
    required this.showErrorMessage,
    required this.failure,
  });

  SignupState copyWith({
    String? email,
    String? password,
    bool? formSubmittedSuccessfully,
    bool? isLoading,
    bool? showErrorMessage,
    Option<AuthFailures>? failure,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      formSubmittedSuccessfully:
      formSubmittedSuccessfully ?? this.formSubmittedSuccessfully,
      isLoading: isLoading ?? this.isLoading,
      showErrorMessage: showErrorMessage ?? this.showErrorMessage,
      failure: failure ?? this.failure,
    );
  }

  @override
  bool operator ==(covariant SignupState other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.formSubmittedSuccessfully == formSubmittedSuccessfully &&
        other.isLoading == isLoading &&
        other.showErrorMessage == showErrorMessage &&
        other.failure == failure;
  }

  @override
  int get hashCode {
    return email.hashCode ^
    password.hashCode ^
    formSubmittedSuccessfully.hashCode ^
    isLoading.hashCode ^
    showErrorMessage.hashCode ^
    failure.hashCode;
  }

  factory SignupState.initial() => SignupState(
    email: "",
    password: "",
    formSubmittedSuccessfully: false,
    isLoading: false,
    showErrorMessage: false,
    failure: none(),
  );
}
