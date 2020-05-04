// FourthScreen.dart -- Brendon

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:contacts_service/contacts_service.dart';

import 'package:BSafe/main.dart';
import 'package:BSafe/FirstScreen.dart';
import 'package:BSafe/SecondScreen.dart';
import 'package:BSafe/ThirdScreen.dart';
import 'package:BSafe/Settings.dart';

class FourthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messaging"),
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
        child: Center(
          child: Column(children: <Widget>[
            panicButton(),
            panicButtonUsingContacts(),
            ]
          )
        ),
      ),

      
      drawer: Drawer(
        child: ListView(  
          children: <Widget>[
            DrawerItem(dLeading:Icon(Icons.map), dTitle:"Map", dOnTap:ThirdScreen()),
            DrawerItem(dLeading:Icon(Icons.contacts), dTitle:"Contacts", dOnTap:SecondScreen()),
            DrawerItem(dLeading:Icon(Icons.timer), dTitle:"Timers", dOnTap:FirstScreen()),
          ]
        )   
      )
    );
  }
}

Future<http.Response> sendPanic(String number) {
  return http.post(
    'http://35.239.59.44:9090/text',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'number': number,
      'message': "this is a test of the panic button feature"
    }),
  );
}

class panicButton extends FourthScreen {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter phone number'),
          ),
        ),
        RaisedButton(
          child: Text('Send Panic Message'),
          onPressed: () {
            sendPanic(_controller.text);
          },
        ),
      ],
    );
  }
}

class panicButtonUsingContacts extends FourthScreen {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text('Send Panic Message Using Contacts'),
          onPressed: () {
            sendPanicToContacts();
          },
        ),
      ],
    );
  }
}

Future<void> sendPanicToContacts() async {
  final Iterable<Contact> contacts = await ContactsService.getContacts();
  contacts.forEach((contact){
    for (var number in contact.phones) {
      var temp = number.value;
      sendPanic(temp);
    }
  });
}

