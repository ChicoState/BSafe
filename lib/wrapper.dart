import 'package:BSafe/auth/auth.dart';
import 'package:BSafe/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:BSafe/main.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Data that's being received, passing in context
    //Accesing each time there is a new user value
    final user = Provider.of<User>(context);
    
    // Check valid user
    return (user == null) ? Authenticate() : MyApp();
  }
}
