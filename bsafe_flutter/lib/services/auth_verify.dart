import 'package:BSafe/models/user.dart';
import 'package:BSafe/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseValidator {
  static User validateUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    //Return user object if true, null if not
    return user != null ? User(uid: user.uid) : null;
  }

  //Auth change user stream
  //Mapping into our user
  Stream<User> get user {
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));'
      .map(_userFromFirebaseUser);
  }

  //Sign in anon
  Future signInAnon() async {
    try {
      // Wait until it's complete to assign the result to some variable
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email/pw
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      //Returns a custom user if successful
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }  

  //Register with email/pw
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // Create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('Name', 'Group');

      //Returns a custom user if successful
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}
