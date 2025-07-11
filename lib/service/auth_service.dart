import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer';

class AuthService {
  // Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      log("Google authentication error: ${error}");
      return null;
    }
  }

  // Google Sign-Out
  Future<void> googleSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      log("Google sign out error: ${error.toString()}");
    }
  }
}
