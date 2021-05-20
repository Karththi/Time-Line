import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthBase {
  Future<AppUser> signInAnonymously();
  Future<void> signOut();
  Future<AppUser> currentUser();
}

class AppUser {
  final String uid;

  AppUser({@required this.uid});
}

class Auth implements AuthBase {
  AppUser _userFromFirebase(User user) {
    return AppUser(uid: user.uid);
  }

  Future<AppUser> signInAnonymously() async {
    final authResult = await FirebaseAuth.instance.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<AppUser> currentUser() async {
    return  _userFromFirebase(FirebaseAuth.instance.currentUser);
  }
}
