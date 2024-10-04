import 'package:fpdart/fpdart.dart';
import '../../../../app_exceptions/failures/auth_failures.dart';
import '../repositories/signin_repository.dart';

class SigninUseCase {
  final SigninRepository _signinRepository;

  SigninUseCase(this._signinRepository);

  Future<Either<AuthFailures, Unit>> call(String email, String password) {

    return _signinRepository.signInUserFirebase(email, password);

  }
}
