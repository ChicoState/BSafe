import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../lib/SecondScreen.dart';
import '../lib/Settings.dart';

void main() {

  testWidgets('Verify secondscreen page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SecondScreen(),
    ));

    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Verify homepage traversal from SecondScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Settings(),
    ));

    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();
    expect(find.text('I don\'t feel safe'), findsWidgets);
  }); 

}