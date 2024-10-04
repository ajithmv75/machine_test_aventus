abstract class SigninEvent {}

class EmailChangedSignin extends SigninEvent {
  final String email;

  EmailChangedSignin(this.email);
}

class PasswordChangedSignin extends SigninEvent {
  final String password;

  PasswordChangedSignin(this.password);
}

class SigninFormSubmittedSignin extends SigninEvent {}
