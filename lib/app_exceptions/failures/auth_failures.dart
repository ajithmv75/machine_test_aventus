abstract interface class AuthFailures {
  String message;

  AuthFailures({required this.message,});
}

class ServerFailure extends AuthFailures {
  ServerFailure({required super.message});
}

class UserBackButtonPressedFailure extends AuthFailures {
  UserBackButtonPressedFailure({required super.message});
}
