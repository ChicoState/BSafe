import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../lib/auth/auth.dart';

void main() {

  testWidgets('Verify transition to authetication state', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Authenticate(),
    ));

    expect(find.text('Sign in anonymously'), findsOneWidget);
  });

  testWidgets('Verify registration option', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Authenticate(),
    ));

    expect(find.text('Register'), findsOneWidget);
  });

  testWidgets('Verify swapping between signin and registration', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Authenticate(),
    ));

    //expect(find.text('Register'), findsOneWidget);
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();
    expect(find.text('Register'), findsOneWidget);
  });

}