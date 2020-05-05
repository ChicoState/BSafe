import 'package:flutter_test/flutter_test.dart';
import 'package:BSafe/auth/register.dart';


void main() {
  test('empty email returns error string', () {
    var result = EmailFieldValidator.validate('');
    expect(result, 'Email cannot be empty.');
  });

  test('non-empty email returns null', () {
    var result = EmailFieldValidator.validate('email');
    expect(result, null);
  });

}