import 'package:BSafe/services/auth_verify.dart';
import 'package:flutter/material.dart';
import 'package:BSafe/shared/constants.dart';
import 'package:BSafe/shared/loading.dart';

// Unit testing classes

class EmailFieldValidator {
  static String validateEmail(String value) {
    return value.isEmpty ? 'Email cannot be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validatePassword(String value) {
    return value.isEmpty ? 'Password cannot be empty' : (value.length < 6 ? 'Enter a password that is at least 6 characters long' : null);
  }
}

// End unit testing classes

class Register extends StatefulWidget {
  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Instance of AuthService class
  final AuthService _auth = AuthService();
  //Identifies form, keeps track of state, validate using key
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  //State variables - text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        title: Text('Register to BSafe'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            }, 
            icon: Icon(Icons.person), 
            label: Text('Sign in')
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Sign in anonymously"),
              onPressed: () async {
                //Dynamic because it could be null or a Firebase user
                //Attempts to signin and waits for this to resolve
                await _auth.signInAnon();
              }
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: EmailFieldValidator.validateEmail,
                    onChanged: (val) {
                      email = val;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: PasswordFieldValidator.validatePassword,
                    onChanged: (val) {
                      password = val;
                    },
                  ),
                  SizedBox(height: 20),
                  RaisedButton (
                    color: Colors.deepPurple,
                    child: Text (
                      'Register',
                      style: TextStyle(color: Colors.white)
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password);

                        if(result == null) {
                          setState(() {
                            error = error = 'Please supply a valid email';
                            loading = false;
                          }); 
                        }
                      }
                    }
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            )
          ]
        )
      ),
    );
  }
}
