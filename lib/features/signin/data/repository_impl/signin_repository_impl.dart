import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../app_exceptions/failures/auth_failures.dart';
import '../../domain/repositories/signin_repository.dart';

class SigninRepositoryImpl implements SigninRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  SigninRepositoryImpl(this._auth, this._googleSignIn);

  @override
  Future<Either<AuthFailures, Unit>> signInUserFirebase(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(unit);
    } on FirebaseException catch (e) {
      log(e.toString(), name: "SigninRepositoryImpl - signInUserFirebase");
      return left(ServerFailure(message: e.code));
    } catch (e) {
      log(e.toString(), name: "SigninRepositoryImpl - signInUserFirebase");
      return left(ServerFailure(message: "Something went wrong"));
    }
  }

  @override
  Future<Either<AuthFailures, Unit>> googleSignIn() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final googleAuthentication = await googleUser.authentication;
        final authCredential = GoogleAuthProvider.credential(
          idToken: googleAuthentication.idToken,
          accessToken: googleAuthentication.accessToken,
        );
        await _auth.signInWithCredential(authCredential);
        return right(unit);
      } else {
        return left(UserBackButtonPressedFailure(message: ""));
      }
    } on FirebaseException catch (e) {
      log(e.toString(), name: "SigninRepositoryImpl - googleSignIn");
      return left(ServerFailure(message: e.code));
    } catch (e) {
      log(e.toString(), name: "SigninRepositoryImpl - googleSignIn");
      return left(ServerFailure(message: "Something went wrong"));
    }
  }
}
