import 'package:fpdart/fpdart.dart';
import '../../../../app_exceptions/failures/auth_failures.dart';

abstract class SignupRepository {
  Future<Either<AuthFailures,Unit>> createUserFirebase(String email, String password);


}
