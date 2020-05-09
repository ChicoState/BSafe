import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:BSafe/FirstScreen.dart';


void main() {

  testWidgets('Find Timers Title', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        home: FirstScreen(),
      ));


      expect(find.text('Timers'), findsOneWidget);
    });
  });

  testWidgets('Push Home Button: Timers', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        home: FirstScreen(),
      ));

      expect(find.byIcon(Icons.home), findsOneWidget);
    });

//    await tester.tap(find.byIcon(Icons.home));
//    await tester.pumpAndSettle();
//    expect(find.byIcon(Icons.home), findsWidgets);
  });

  testWidgets('Push Settings Button: Timers', (WidgetTester tester) async {
    await tester.runAsync(() async {
    await tester.pumpWidget(MaterialApp(
      home: FirstScreen(),
    ));

    expect(find.byIcon(Icons.settings), findsOneWidget);
    });
  });

  testWidgets('Push Drawer Button: Timers', (WidgetTester tester) async {
      await tester.runAsync(() async {
    await tester.pumpWidget(MaterialApp(
      home: FirstScreen(),
    ));

    expect(find.byIcon(Icons.menu), findsOneWidget);
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.arrow_right), findsWidgets);
    expect(find.byIcon(Icons.map), findsWidgets);
    expect(find.byIcon(Icons.contacts), findsWidgets);
    expect(find.byIcon(Icons.message), findsWidgets);
  });
  });
}
