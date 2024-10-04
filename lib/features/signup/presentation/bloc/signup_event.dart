abstract class SignupEvent {}

class EmailChangedSignup extends SignupEvent {
  final String email;

  EmailChangedSignup(this.email);
}

class PasswordChangedSignup extends SignupEvent {
  final String password;

  PasswordChangedSignup(this.password);
}

class SignupFormSubmittedSignup extends SignupEvent {}
