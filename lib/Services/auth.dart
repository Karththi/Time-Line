import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  Stream<AppUser> get authStateChanges;
  Future<AppUser> signInAnonymously();
  Future<AppUser> signInWithGoogle();
  Future<void> signOut();
  Future<AppUser> currentUser();
}

class AppUser {
  final String uid;

  AppUser({@required this.uid});
}

class Auth implements AuthBase {
  //Getter variable - to get authStateChanges Stream<AppUser>
  Stream<AppUser> get authStateChanges {
    return FirebaseAuth.instance.authStateChanges().map(_userFromFirebase);
  }

  //User Object ---> AppUser Object
  AppUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return AppUser(uid: user.uid);
  }

  Future<AppUser> signInAnonymously() async {
    final authResult = await FirebaseAuth.instance.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<AppUser> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      if (googleSignInAuthentication.accessToken != null &&
          googleSignInAuthentication.idToken != null) {
        final authResult = await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
                accessToken: googleSignInAuthentication.accessToken,
                idToken: googleSignInAuthentication.idToken));
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
            code: "ERROR-MISSING GOOGLE AUTH TOKEN",
            message: "Missing Google Auth Token");
      }
    } else {
      throw PlatformException(
          code: "ERROR-ABORTED BY USER", message: "Sign in aborted by user");
    }
  }

  Future<void> signOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<AppUser> currentUser() async {
    return _userFromFirebase(FirebaseAuth.instance.currentUser);
  }
}
