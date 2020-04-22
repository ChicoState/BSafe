// main.dart
import 'package:BSafe/models/user.dart';
import 'package:BSafe/services/auth_verify.dart';
import 'package:BSafe/wrapper.dart';
import 'package:flutter/material.dart';

// IMPORT NEW SCREENS HERE
import 'package:BSafe/FirstScreen.dart';
import 'package:BSafe/SecondScreen.dart';
import 'package:BSafe/ThirdScreen.dart';
import 'package:BSafe/FourthScreen.dart';
import 'package:BSafe/Settings.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Starting());
}

// --- Start of Custom Drawer Widget
class DrawerItem extends StatelessWidget {
  DrawerItem({Key key, this.dLeading, this.dTitle, this.dOnTap}) : super(key: key);

  final Widget dLeading;
  final String dTitle;
  final Widget dOnTap;

  //@override
  Widget build(BuildContext context) {
    /*
    return MaterialApp(
      home: Wrapper(),
    );
    */
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

class Starting extends StatefulWidget {
  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  @override
  Widget build(BuildContext context) {
    //Provider
    return StreamProvider<User>.value (
        //Listening to:
        value: AuthService().user,
        //Wrapping material app
        child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

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


// --- Permission Requesting
class PermissionsService {
  final PermissionHandler _permissionHandler = PermissionHandler();

 Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestContactsPerm({Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.contacts);
    if (!granted) {
      onPermissionDenied();
    }
    return granted;
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
  final AuthService _auth = AuthService();

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
        elevation: 0.0,
          actions: <Widget> [
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              }, 
              icon: Icon(Icons.person), 
              label: Text('Logout')
            ),
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
