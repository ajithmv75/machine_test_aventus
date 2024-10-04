import 'package:fpdart/fpdart.dart';

import '../../../../app_exceptions/failures/auth_failures.dart';

abstract class SigninRepository {

  Future<Either<AuthFailures, Unit>> signInUserFirebase(String email, String password);

  Future<Either<AuthFailures, Unit>> googleSignIn();

}
