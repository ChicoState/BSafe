// ThirdScreen.dart -- Chris / Logan

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:BSafe/main.dart';
import 'package:BSafe/FirstScreen.dart';
import 'package:BSafe/SecondScreen.dart';
import 'package:BSafe/FourthScreen.dart';

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),

      body: MyMap(title: 'BSafe'),

      drawer: Drawer(
        child: ListView(  
          children: <Widget>[
            DrawerItem(dLeading:Icon(Icons.home), dTitle:"Home", dOnTap:MyApp()),
            DrawerItem(dLeading:Icon(Icons.contacts), dTitle:"Contacts", dOnTap:SecondScreen()),
            DrawerItem(dLeading:Icon(Icons.message), dTitle:"Messaging", dOnTap:FourthScreen()),
            DrawerItem(dLeading:Icon(Icons.timer), dTitle:"Timers", dOnTap:FirstScreen()),
          ]
        )
      )
    );
  }
}

class MyMap extends StatefulWidget {
  MyMap({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  GoogleMapController mapController;
  //*** Coordinates for chico
  final LatLng _center = const LatLng(37.4219983, -122.084);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      );
  }
}
