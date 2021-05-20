import 'package:flutter/material.dart';

import 'Services/auth.dart';

class SignInOptions extends StatelessWidget {
  final Function(AppUser) onSignIn;
  final AuthBase auth;
  //SignInOptions class variable [ DataType-->Function(User) variableName-->onSignIn ]
  //onSignIn is a callback function
  SignInOptions({@required this.onSignIn,@required this.auth}); //Named Constructor with Function<User> parameter

  Future<void> signInAnonymosly() async {
    final user = await auth.signInAnonymously();
    //Sign in annonymously & pass the user credentials to authResult
    onSignIn(user);
    //When a user signs in successfully, call this callback method which will update landing page automatically
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TimeLine",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4.0,
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.purple[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: deviceSize.height * 0.1),
              buildWelcomeBack(),
              SizedBox(height: deviceSize.height * 0.1),
              buildEmailSignupButton(),
              SizedBox(height: 8.0),
              buildGoogleSignupButton(),
              SizedBox(height: 8.0),
              buildFacebookSignupButton(),
              SizedBox(height: 8.0),
              Text(
                'or',
                style: TextStyle(fontSize: 15.0, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              buildGoAnnonymousButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmailSignupButton() {
    return RaisedButton(
        child: Text(
          "Sign in with Email",
          style: TextStyle(fontSize: 16),
        ),
        color: Colors.purple[300],
        textColor: Colors.white,
        onPressed: () {});
  }

  Widget buildGoogleSignupButton() {
    return RaisedButton(
        color: Colors.white,
        textColor: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('images/google-logo.png'),
            Text("Sign in with Google", style: TextStyle(fontSize: 16)),
            Opacity(
              opacity: 0.0,
              child: Image.asset('images/google-logo.png'),
            ),
          ],
        ),
        onPressed: () {});
  }

  Widget buildFacebookSignupButton() {
    return RaisedButton(
        color: Color(0xFF334D92),
        textColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('images/facebook-logo.png'),
            Text("Sign in with Facebook", style: TextStyle(fontSize: 16)),
            Opacity(
              opacity: 0.0,
              child: Image.asset('images/facebook-logo.png'),
            ),
          ],
        ),
        onPressed: () {});
  }

  Widget buildGoAnnonymousButton() {
    return RaisedButton(
        child: Text(
          "Go Annonymous",
          style: TextStyle(fontSize: 16),
        ),
        color: Colors.white,
        textColor: Colors.purple[600],
        onPressed: signInAnonymosly);
  }

  Widget buildWelcomeBack() {
    return SizedBox(
      height: 50.0,
      child: Column(
        children: [
          Text(
            'Welcome Back :)',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
                color: Colors.purple[600]),
          ),
        ],
      ),
    );
  }
}
