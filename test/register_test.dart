import 'package:flutter_test/flutter_test.dart';
import 'package:BSafe/auth/register.dart';
import 'package:flutter/material.dart';

void main() {

  testWidgets('Verify transition to register page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Register(),
    ));

    expect(find.text('Sign in anonymously'), findsOneWidget);
  });

}
