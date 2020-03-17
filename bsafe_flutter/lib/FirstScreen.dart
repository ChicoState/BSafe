// FirstScreen.dart -- Samantha

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: MyHomePage(title: 'BSafe'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  Position pos;
  String lat = "1st";
  String long = "2nd";

  //*** Asynchronous function that gets your geoposition and stores it into lat and long variables
  Future<Position>  getPos() async {
    pos = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat = pos.latitude.toString();
    long = pos.longitude.toString();

    return pos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Samantha\'s Page: Your geolocation is:',
            ),
            Text(
              'Lat: $lat \nLong: $long',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              'You\'ve requested your location $counter times.',
            ),
          ],
        ),
      ),
      //
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      //
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          getPos();
          counter++;
        }),
        tooltip: 'Geolocation',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, //*** Centers the action button to the bottom-center
    );
  }
}
