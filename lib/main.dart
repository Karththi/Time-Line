import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './landing_screen.dart';
import 'Services/auth.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Intializer(),
    );
  }
}

class Intializer extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text("Something went Wrong!"),),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return LandingScreen(
              auth: Auth(),
            );
          }
          return Scaffold(
            body: Center(child: Text("Loading"),),
          );
        });
  }
}
