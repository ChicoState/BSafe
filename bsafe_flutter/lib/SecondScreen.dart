// SecondScreen.dart -- Samantha

import 'package:flutter/material.dart';

import 'package:BSafe/main.dart';
import 'package:BSafe/FirstScreen.dart';
import 'package:BSafe/ThirdScreen.dart';
import 'package:BSafe/FourthScreen.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),

      drawer: Drawer(
        child: ListView(  
          children: <Widget>[
            DrawerItem(dLeading:Icon(Icons.home), dTitle:"Home", dOnTap:MyApp()),
            DrawerItem(dLeading:Icon(Icons.map), dTitle:"Map", dOnTap:ThirdScreen()),
            DrawerItem(dLeading:Icon(Icons.message), dTitle:"Messaging", dOnTap:FourthScreen()),
            DrawerItem(dLeading:Icon(Icons.timer), dTitle:"Timers", dOnTap:FirstScreen()),
          ]
        )   
      )
    );
  }
}