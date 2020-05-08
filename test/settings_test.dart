import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../lib/Settings.dart';

void main() {
  
  testWidgets('Verify Settings framework', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Settings(),
    ));

    expect(find.text('Settings'), findsWidgets);
  }); 

  testWidgets('Verify MyApp traversal from Settings', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Settings(),
    ));

    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();
    expect(find.text('I don\'t feel safe'), findsOneWidget);
  }); 

}