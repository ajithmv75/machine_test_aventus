import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';

class AuthCheckUseCase {
  final AuthRepository _authRepository;
  AuthCheckUseCase(this._authRepository);
  User? call() {
    return _authRepository.authCheckEvent();
  }
}
