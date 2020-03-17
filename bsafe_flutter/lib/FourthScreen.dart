// FourthScreen.dart -- Brendon

import 'package:flutter/material.dart';

import 'package:BSafe/main.dart';
import 'package:BSafe/FirstScreen.dart';
import 'package:BSafe/SecondScreen.dart';
import 'package:BSafe/ThirdScreen.dart';

class FourthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messaging"),
      ),

      drawer: Drawer(
        child: ListView(  
          children: <Widget>[
            DrawerItem(dLeading:Icon(Icons.home), dTitle:"Home", dOnTap:MyApp()),
            DrawerItem(dLeading:Icon(Icons.map), dTitle:"Map", dOnTap:ThirdScreen()),
            DrawerItem(dLeading:Icon(Icons.contacts), dTitle:"Contacts", dOnTap:SecondScreen()),
            DrawerItem(dLeading:Icon(Icons.timer), dTitle:"Timers", dOnTap:FirstScreen()),
          ]
        )   
      )
    );
  }
}