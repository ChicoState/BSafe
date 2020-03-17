// main.dart

import 'package:flutter/material.dart';

// IMPORT NEW SCREENS HERE
import 'package:BSafe/FirstScreen.dart';
import 'package:BSafe/SecondScreen.dart';
import 'package:BSafe/ThirdScreen.dart';
import 'package:BSafe/FourthScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appTitle = "BSafe";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Main Page')),
      drawer: Drawer(
        child: ListView(  
          children: <Widget>[ 
            ListTile(
              leading: Icon(Icons.map),
              title: Text("Map"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdScreen()),
                );
              },              
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("Contacts"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },              
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text("Messaging"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FourthScreen()),
                );
              },              
            ),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text("Timers"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstScreen()),
                );
              },              
            ),
          ]
        )   
      )
    );
  }
}

/*
class DrawerItem extends StatelessWidget {
  final String title;
  DrawerItem({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
    );
  }
}
*/
