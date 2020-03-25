// ThirdScreen.dart -- Chris / Logan

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'package:BSafe/main.dart';
import 'package:BSafe/FirstScreen.dart';
import 'package:BSafe/SecondScreen.dart';
import 'package:BSafe/FourthScreen.dart';
import 'package:BSafe/Settings.dart';

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Map"),
            actions: <Widget> [
              IconButton(
                icon: const Icon(Icons.home),
                tooltip: 'Homepage',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
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

        body: MyMap(title: 'BSafe'),

        drawer: Drawer(
            child: ListView(
                children: <Widget>[
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
  Completer<GoogleMapController> _controller = Completer();
  final Map<String, Marker> _markers = {};

  //*** Geolocation API Documentation: https://pub.dev/packages/geolocator#-readme-tab-
  Future<String> _getAddress(Position loc) async {
    List<Placemark> placemarks = await Geolocator().placemarkFromCoordinates(loc.latitude, loc.longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark loc = placemarks[0];
      //*** Grab the street, city, and postal code from your location
      return loc.thoroughfare + ', ' + loc.locality + ', ' + loc.postalCode;

    }
    return "";
  }

  //*** GoogleMapController Documentation: https://pub.dev/packages/google_maps_flutter
  Future<void> _moveToPosition(Position loc) async {
    final GoogleMapController mapController = await _controller.future;
    if(mapController == null) return;
    //*** Move Camera to current location
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(loc.latitude, loc.longitude),
          zoom: 15.0,
        )
    )
    );
  }
  void _getLoc() async {
    //*** Grab Current Location of the Device
    Position currloc = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    var currentAddress = await _getAddress(currloc);
    await _moveToPosition(currloc);

    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currloc.latitude, currloc.longitude),
        infoWindow: InfoWindow(title: currentAddress),
      );
      _markers["Current Location"] = marker;
    });
  }

  //*** Coordinates for chico
  final LatLng _center = const LatLng(39.8283, -98.5795);

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller.complete(controller);
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SafeArea(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 1.0,
            ),
            markers: _markers.values.toSet(),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepPurple,
          onPressed: _getLoc,
          label: Text('Location'),
          icon: Icon(Icons.directions_walk),
        )
    );
  }
}
