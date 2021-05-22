import 'package:flutter/material.dart';

import './home_screen.dart';
import './signInOptions_screen.dart';
import 'Services/auth.dart';

class LandingScreen extends StatefulWidget {
  final AuthBase auth; 
  LandingScreen({@required this.auth});//AuthBase auth=new Auth();
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  AppUser _appUser; //State Variable

  @override
  //initState is called as part of Widget Creation life cycle
  void initState() {
    //used to initialize state variables
    super.initState();
    _currentUser();
  }

  Future<void> _currentUser() async {
    AppUser appUser = await widget.auth.currentUser();
    _updateUser(appUser);
  }

  void _updateUser(AppUser appuUser) {
    //This method will be called after successful signIn
    setState(() {
      //Ealier _user value null & After successful signIn, _user variable has value.
      _appUser = appuUser;
    });
  }

  void _setUser() {
    //This method will be called after logout
    _updateUser(null); //Update the user as null
  }

  @override
  Widget build(BuildContext context) {
    if (_appUser == null)
      return SignInOptions(
        onSignIn: _updateUser,
        auth: widget.auth,//auth object is in outside of _LandingScreenState class.
      );
    return HomeScreen(voidCallback: _setUser, auth: widget.auth);
  }
}
