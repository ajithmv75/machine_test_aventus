import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../app_exceptions/failures/auth_failures.dart';
import '../../domain/repositories/signup_repository.dart';

class SignupRepositoryImpl implements SignupRepository {
  final FirebaseAuth _auth;

  SignupRepositoryImpl(
      this._auth,
      );

  @override
  Future<Either<AuthFailures, Unit>> createUserFirebase(
      String email,
      String password,
      ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure(message: e.code));
    } catch (e) {
      log(e.toString(), name: "SignupRepositoryImpl - createUserFirebase");
      return left(ServerFailure(message: "Something went wrong"));
    }
  }
}
