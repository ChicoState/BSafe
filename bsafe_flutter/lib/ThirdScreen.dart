// ThirdScreen.dart -- Chris / Logan

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: MyMap(title: 'BSafe'),
      ),
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:Center(
            child:Text('Map'),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}

