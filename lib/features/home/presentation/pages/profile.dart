import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:machine_test/features/home/presentation/pages/orderpage.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } catch (error) {
      print("Error signing in with Google: $error");
    }
  }

  Future<void> _signOut(BuildContext context) async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/Signin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text("Ordered items"),
              onPressed: () {
                // Navigator.pushNamed(context, '/OrdersPage');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersPage()),
                );
              },
            ),
            StreamBuilder<User?>(
              stream: _auth.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  User? user = snapshot.data;
                  return Column(
                    children: [
                      Text("Welcome, ${user!.displayName}"),
                      Text("Email: ${user.email}"),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _signOut(context);
                        },
                        child: const Text("Sign Out"),
                      ),
                    ],
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () => _signInWithGoogle(context),
                    child: const Text("Sign in with Google"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
