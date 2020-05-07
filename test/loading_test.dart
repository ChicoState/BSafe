
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../lib/shared/loading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  testWidgets('Verify Loading framework', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Loading(),
    ));

    expect(find.byType(SpinKitDoubleBounce), findsOneWidget);
  }); 

}