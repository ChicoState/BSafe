// main.dart

import 'package:flutter/material.dart';

// IMPORT NEW SCREENS HERE
import 'package:BSafe/FirstScreen.dart';
import 'package:BSafe/SecondScreen.dart';
import 'package:BSafe/ThirdScreen.dart';
import 'package:BSafe/FourthScreen.dart';
import 'package:BSafe/Settings.dart';

import 'package:permission_handler/permission_handler.dart';

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
      home: MyHomePage(),
    );
  }
}


//
class PermissionsService {
  final PermissionHandler _permissionHandler = PermissionHandler();

 Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  // Permission for contacts
  Future<bool> requestContactsPermission() async {
    return _requestPermission(PermissionGroup.contacts);
  }
  // Permission for location
  Future<bool> requestLocationPermission() async {
    return _requestPermission(PermissionGroup.locationWhenInUse);
  }
}
//


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  @override
  initState() {
    super.initState();
    requestPerm();
  }

  Future<void> requestPerm() async {
    await PermissionsService().requestContactsPermission();
    await PermissionsService().requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("BSafe"),
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
      body: SafeArea(
        child: Center(
        child: Text('Main Page')
        ),
      ),
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
