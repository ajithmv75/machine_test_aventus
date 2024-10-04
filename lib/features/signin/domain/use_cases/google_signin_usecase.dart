import 'package:fpdart/fpdart.dart';
import '../../../../app_exceptions/failures/auth_failures.dart';
import '../repositories/signin_repository.dart';


class GoogleSignInUseCase {
  final SigninRepository _signinRepository;

  GoogleSignInUseCase(this._signinRepository);

  Future<Either<AuthFailures, Unit>> call() {
    return _signinRepository.googleSignIn();
  }
}
