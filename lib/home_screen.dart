import 'package:flutter/material.dart';
import 'package:signup/Services/auth.dart';

class HomeScreen extends StatelessWidget {
  final AuthBase auth;
  HomeScreen({@required this.auth});

  Future<void> _signOut() async {
    //log out when user press log out button
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "Home Page",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          FlatButton(
              onPressed: _signOut,
              child: Text(
                "Log out",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ))
        ],
      ),
    );
  }
}
