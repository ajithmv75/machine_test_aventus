
String? isValidEmail(String? email) {
  if (email == null) {
    return "Invalid email";
  }
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  if (emailValid) {
    return null;
  }

  return "Invalid email";
}

String? isPasswordValid(String? password) {
  if (password == null) {
    return "Invalid Password";
  }
  if (password.isEmpty || password.length < 8) {
    return "Invalid Password";
  }
  return null;
}
