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

  testWidgets('Verify app Starting framework', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Starting(),
    ));

    expect(find.widgetWithText(RaisedButton, 'Sign in anonymously'), findsOneWidget);
  });  

  testWidgets('Verify MyApp framework', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyApp(),
    ));

    expect(find.text('BSafe'), findsOneWidget);
  });

  testWidgets('Verify Settings traversal from MyApp', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyApp(),
    ));

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsWidgets);
  });

  testWidgets('Verify swapping to registration', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Starting(),
    ));

    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    expect(find.text('Sign in'), findsOneWidget);
  });

  testWidgets('Verify swapping between signin and registration', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Starting(),
    ));

    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();
    expect(find.text('Register'), findsOneWidget);
  });

  testWidgets('Sign in button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Starting(),
    ));

    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Email cannot be empty'), findsOneWidget);
  });

  testWidgets('Sign in button - no email message', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Starting(),
    ));

    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Email cannot be empty'), findsOneWidget);
  });

  testWidgets('Sign in button - no password message', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Starting(),
    ));

    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Password cannot be empty'), findsOneWidget);
  });

  testWidgets('Register button - no email message', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Starting(),
    ));

    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.text('Password cannot be empty'), findsOneWidget);
  });

  testWidgets('Register button - no password message', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Starting(),
    ));

    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.text('Email cannot be empty'), findsOneWidget);
  });

  testWidgets('Test onPressed for Home Panic Button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyApp(),
    ));

    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();
    expect(find.text('I don\'t feel safe'), findsWidgets);
  });


}
