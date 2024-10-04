import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl(this._auth, this._googleSignIn);
  @override
  Future<void> signOut() {
    return Future.wait([
      _googleSignIn.signOut(),
      _auth.signOut(),
    ]);
  }
  
  @override
 User? authCheckEvent() {
return _auth.currentUser;
  }
}
