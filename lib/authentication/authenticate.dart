import 'package:bronexion/authentication/register.dart';
import 'package:bronexion/authentication/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    print("Called");
    setState(() {
      showSignIn = !showSignIn;
    });
    print(showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Sign_In(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
