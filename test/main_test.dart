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
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Starting(),
    ));

    expect(find.text('Sign in anonymously'), findsOneWidget);
  });  

  testWidgets('Verify MyApp framework', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyApp(),
    ));

    expect(find.text('BSafe'), findsOneWidget);
  }); 

}
