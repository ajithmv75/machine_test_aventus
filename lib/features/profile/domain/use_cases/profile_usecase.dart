import 'package:firebase_auth/firebase_auth.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

class ProfileUseCase {
  final AuthRepository _authRepository;
  ProfileUseCase(this._authRepository);

  User? call() {
    return _authRepository.authCheckEvent();
  }
}
