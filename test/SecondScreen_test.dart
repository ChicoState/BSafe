import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../lib/SecondScreen.dart';
import '../lib/Settings.dart';
import '../lib/main.dart';

void main() {

  testWidgets('Verify secondscreen page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SecondScreen(),
    ));

    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Verify MyApp traversal from SecondScreen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SecondScreen(),
    ));

    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();
    expect(find.text('I don\'t feel safe'), findsWidgets);
  }); 

  testWidgets('Verify Settings traversal from SecondScreen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SecondScreen(),
    ));

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsWidgets);
  }); 

  testWidgets('Verify search icon on SecondScreen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ContactsPage(),
    ));

    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Verify search hint text appears', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ContactsPage(),
    ));

    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();
    expect(find.text('Search...'), findsOneWidget);
  });

}