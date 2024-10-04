import 'package:fpdart/fpdart.dart';
import '../../../../app_exceptions/failures/auth_failures.dart';
import '../repositories/signup_repository.dart';

class SignupUseCase {
  final SignupRepository _signupRepository;

  SignupUseCase(this._signupRepository);

  Future<Either<AuthFailures, Unit>> call(String email, String password) {
    return _signupRepository.createUserFirebase(email, password);
  }
}
