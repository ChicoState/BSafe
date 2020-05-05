import 'package:flutter_test/flutter_test.dart';
import 'package:BSafe/services/auth_verify.dart';

void main() {
  test('firebase user is null', () {
    var result = FirebaseValidator.validateUser(null);
    expect(result, null);
  });
}