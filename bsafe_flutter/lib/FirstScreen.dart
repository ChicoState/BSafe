// FirstScreen.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:BSafe/main.dart';
import 'package:BSafe/SecondScreen.dart';
import 'package:BSafe/ThirdScreen.dart';
import 'package:BSafe/FourthScreen.dart';
import 'package:BSafe/Settings.dart';


class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timers"),
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
      
      body: SafeArea(
        child:TimerApp(),
      ),
      
      drawer: Drawer(
        child: ListView(  
          children: <Widget>[
            DrawerItem(dLeading:Icon(Icons.map), dTitle:"Map", dOnTap:ThirdScreen()),
            DrawerItem(dLeading:Icon(Icons.contacts), dTitle:"Contacts", dOnTap:SecondScreen()),
            DrawerItem(dLeading:Icon(Icons.message), dTitle:"Messaging", dOnTap:FourthScreen()),
          ]
        )
      )
    );
  }
}

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed - 1;
      });
      if (secondsPassed == 0){
        sendPanicToContacts();
        setState(() {
          isActive = false;
        });
      }
    }
  }

  void setTime(String hours,String minutes,String seconds){
    setState(() {
      secondsPassed = int.parse(hours)*3600 + int.parse(minutes)*60 + int.parse(seconds);
    });
  }

  final TextEditingController _hours = TextEditingController();
  final TextEditingController _minutes = TextEditingController();
  final TextEditingController _seconds = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }
    int seconds = secondsPassed % 60;
    int minutes = (secondsPassed ~/ 60) % 60;
    int hours = secondsPassed ~/ (60 * 60);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new TextField(
                          controller: _hours,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Hours',
                              contentPadding: EdgeInsets.all(10)
                          )
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    new Flexible(
                      child: new TextField(
                          controller: _minutes,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Minutes',
                              contentPadding: EdgeInsets.all(10)
                          )
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    new Flexible(
                      child: new TextField(
                          controller: _seconds,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Seconds',
                              contentPadding: EdgeInsets.all(10)
                          )
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                    color: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Text('Update Panic Timer',
                        style: TextStyle(
                          color: Colors.white,)
                    ),
                  onPressed: () {
                    setTime(_hours.text,_minutes.text,_seconds.text);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LabelText(
                        label: 'HRS', value: hours.toString().padLeft(2, '0')),
                    LabelText(
                        label: 'MIN',
                        value: minutes.toString().padLeft(2, '0')),
                    LabelText(
                        label: 'SEC',
                        value: seconds.toString().padLeft(2, '0')),
                  ],
                ),
                SizedBox(height: 60),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    color: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(isActive ? 'STOP' : 'START',
                      style: TextStyle(
                        color: Colors.white,)
                    ),
                    onPressed: () {
                      setState(() {
                        isActive = !isActive;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class LabelText extends StatelessWidget {
  LabelText({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.deepPurple,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 55, fontWeight: FontWeight.bold),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}