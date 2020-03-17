// main.dart

import 'package:flutter/material.dart';

// IMPORT NEW SCREENS HERE
import 'package:BSafe/FirstScreen.dart';
import 'package:BSafe/SecondScreen.dart';
import 'package:BSafe/ThirdScreen.dart';
import 'package:BSafe/FourthScreen.dart';
import 'package:BSafe/Settings.dart';

void main() {
  runApp(MyApp());
}

// --- Start of Custom Drawer Widget
class DrawerItem extends StatelessWidget {
  DrawerItem({Key key, this.dLeading, this.dTitle, this.dOnTap}) : super(key: key);

  final Widget dLeading;
  final String dTitle;
  final Widget dOnTap;

  //@override
  Widget build(BuildContext context) {
    return InkWell(
        child: ListTile(
          leading: dLeading,
          title: Text(dTitle),
          trailing: Icon(Icons.arrow_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => dOnTap),
            );
          }, 
        )
    );
  }
}
// --- End of Custom Drawer Widget

class MyApp extends StatelessWidget {
  final appTitle = "BSafe";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.deepPurple,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
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
      appBar: AppBar(
        title: Text(title),
          actions: <Widget> [
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },            
            )
          ]
        ),
      body: Center(child: Text('Main Page')),
      drawer: Drawer(
        child: ListView(  
          children: <Widget>[ 
            DrawerItem(dLeading:Icon(Icons.map), dTitle:"Map", dOnTap:ThirdScreen()),
            DrawerItem(dLeading:Icon(Icons.contacts), dTitle:"Contacts", dOnTap:SecondScreen()),
            DrawerItem(dLeading:Icon(Icons.message), dTitle:"Messaging", dOnTap:FourthScreen()),
            DrawerItem(dLeading:Icon(Icons.timer), dTitle:"Timers", dOnTap:FirstScreen()),
          ]
        )   
      )
    );
  }
}
