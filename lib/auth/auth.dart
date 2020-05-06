import 'package:BSafe/auth/register.dart';
import 'package:BSafe/auth/signin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  @override
  Widget build(BuildContext context) {
    void toggleView() {
      setState(() => showSignIn = !showSignIn);
    }

    return showSignIn ? SignIn(toggleView: toggleView) : Register(toggleView: toggleView);
  }
}
