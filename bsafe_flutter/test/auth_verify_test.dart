import 'package:flutter_test/flutter_test.dart';
import 'package:BSafe/services/auth_verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:BSafe/models/user.dart';

void main() {
  test('firebase user is null', () {
    var result = FirebaseValidator.validateUser(null);
    expect(result, null);
  });

/*
  test('firebase user is not null', () async{
    User _userFromFirebaseUser(FirebaseUser user) {
      return User(uid: user.uid);
    }


    FirebaseUser 'test@gmail.com';
    String user = _userFromFirebaseUser(admin).toString();

    String result = "gsubV46vJDSX8BA9XQLljOorfjw2";

    
    expect(admin.uid, _userFromFirebaseUser(admin));
  });
*/
}