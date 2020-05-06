// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:BSafe/auth/register.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:BSafe/main.dart';
import 'package:flutter/material.dart';

void main() {

  testWidgets('verify panic button and text', (tester) async {
    await tester.pumpWidget(new MyApp());
    expect(find.widgetWithText(RaisedButton, 'I don\'t feel safe'), findsOneWidget);
  });

  testWidgets('verify logout icon is present', (tester) async {
    await tester.pumpWidget(new MyApp());
    expect(find.byIcon(Icons.person), findsOneWidget);
  });

  testWidgets('verify settings icon is present', (tester) async {
    await tester.pumpWidget(new MyApp());
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });

  testWidgets('verify title', (tester) async {
    await tester.pumpWidget(new MyApp());
    expect(find.text('BSafe'), findsOneWidget);
  });

  testWidgets('verify drawer icon', (tester) async {
    await tester.pumpWidget(new MyApp());
    find.byIcon(Icons.arrow_right);
  });

  testWidgets('Verify transition to register page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Register(),
    ));

    expect(find.text('Sign in anonymously'), findsOneWidget);
  });

}
