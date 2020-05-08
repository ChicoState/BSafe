import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../lib/auth/signin.dart';

void main() {

  testWidgets('Verify transition to signin page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SignIn(),
    ));

    expect(find.text('Sign in anonymously'), findsOneWidget);
  });

}
