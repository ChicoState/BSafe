import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import '../lib/SecondScreen.dart';

void main() {

  testWidgets('Verify secondscreen page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SecondScreen(),
    ));

    expect(find.byIcon(Icons.search), findsOneWidget);
  });

}