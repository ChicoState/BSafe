import 'package:BSafe/services/auth_verify.dart';
import 'package:flutter/material.dart';
import 'package:BSafe/shared/constants.dart';
import 'package:BSafe/shared/loading.dart';

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
                dynamic result = await _auth.signInAnon();

                if (result == null) {
                  print('Error registering');
                } else {
                  //Received user object
                  print('Registered');
                  //print(result);
                  print(result.uid);
                }
              }
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      //setState(() => email = val);
                      email = val;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Enter a password that is at least 6 characters long' : null,
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
        /*
        child: RaisedButton(
          child: Text("Sign in anonymously"),
          onPressed: () async {
            //Dynamic because it could be null or a Firebase user
            //Attempts to signin and waits for this to resolve
            dynamic result = await _auth.signInAnon();

            if (result == null) {
              print('Error signing in');
            } else {
              //Received user object
              print('Signed in');
              //print(result);
              print(result.uid);
            }
          }
        ),
        */
      ),
    );
  }
}