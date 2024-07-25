// ignore_for_file: unused_field, body_might_complete_normally_nullable, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:google_sign_in/google_sign_in.dart';

@immutable
class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    //?
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    //? get google authentification credentials
    final googleAuth = await googleUser.authentication;

    //? convert google credential to firebase credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //? Sign in to firebase with google credentials
    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
