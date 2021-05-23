import 'package:flutter/material.dart';

import './home_screen.dart';
import './signInOptions_screen.dart';
import 'Services/auth.dart';

class LandingScreen extends StatelessWidget {
  final AuthBase auth;
  LandingScreen({@required this.auth});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: auth.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.active) {
            AppUser appUser = snapshot.data;
            if (appUser == null)
              return SignInOptions(
                auth: 
                    auth, 
              );
            return HomeScreen( auth: auth);
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
        });
  }
}
