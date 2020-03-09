// main.dart

// ADD NEW SCREENS HERE

import 'package:flutter/material.dart';

// IMPORT TAB FILES HERE
import 'FirstScreen.dart';
import 'SecondScreen.dart';
import 'ThirdScreen.dart';
import 'FourthScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4, // CHANGE WHEN ADDING A NEW SCREEN
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                // ADD TABS HERE
                Tab(icon: Icon(Icons.location_on)),
                Tab(icon: Icon(Icons.contacts)),
                Tab(icon: Icon(Icons.map)),
                Tab(icon: Icon(Icons.textsms)),
              ],
            ),
            title: Text('BSafe'),
          ),
          body: TabBarView(
            children: [
              FirstScreen(),
              SecondScreen(),
              ThirdScreen(),
              FourthScreen(),
            ],
          ),
        ),
      ),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}