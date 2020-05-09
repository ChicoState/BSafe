import 'dart:async';
import 'package:BSafe/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:BSafe/FourthScreen.dart';
import 'package:http/http.dart' as http;

void main(){

  testWidgets('Find Messaging Title', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
      home: FourthScreen(),
    ));

    expect(find.text('Messaging'), findsOneWidget);
  });

  testWidgets('Push PanicButton', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: FourthScreen(),
    ));

    expect(find.byType(PanicButton), findsOneWidget);
    await tester.tap(find.byType(PanicButton));
    await tester.pumpAndSettle();
    find.descendant(of: find.text('Send Panic Message'), matching: find.byType(PanicButton));
  });

  testWidgets('Push PanicButtonUsingContacts', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: FourthScreen(),
    ));

    expect(find.byType(PanicButtonUsingContacts), findsOneWidget);
    await tester.tap(find.byType(PanicButtonUsingContacts));
    await tester.pumpAndSettle();
    find.descendant(of: find.text('Send Panic Message'), matching: find.byType(PanicButtonUsingContacts));
  });

//  testWidgets('verify drawer icon', (tester) async {
//    await tester.pumpWidget(new MyApp());
//    find.byIcon(Icons.arrow_right);
//  });

  testWidgets('Push Text Field', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: FourthScreen(),
    ));

    expect(find.byType(TextField), findsOneWidget);
    await tester.tap(find.byType(PanicButtonUsingContacts));
    await tester.pumpAndSettle();
    find.descendant(of: find.text('Enter phone number'), matching: find.byType(TextField));
  });

  testWidgets('Push Home Button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: FourthScreen(),
    ));

    expect(find.byIcon(Icons.home), findsOneWidget);
//    await tester.tap(find.byIcon(Icons.home));
//    await tester.pumpAndSettle();
//    expect(find.byIcon(Icons.home), findsWidgets);
  });

  testWidgets('Push Settings Button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: FourthScreen(),
    ));

    expect(find.byIcon(Icons.settings), findsOneWidget);
  });

  testWidgets('Push Drawer Button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: FourthScreen(),
    ));

    expect(find.byIcon(Icons.menu), findsOneWidget);
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.arrow_right), findsWidgets);
    expect(find.byIcon(Icons.map), findsWidgets);
    expect(find.byIcon(Icons.contacts), findsWidgets);
    expect(find.byIcon(Icons.timer), findsWidgets);
  });

//  test('Test Post Request',() async {
//    http.Response res = await sendPanic("4159711087");
//    expect(res.statusCode,200);
//  });
}
