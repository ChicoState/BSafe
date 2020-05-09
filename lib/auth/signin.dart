import 'package:BSafe/services/auth_verify.dart';
import 'package:BSafe/shared/constants.dart';
import 'package:BSafe/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:BSafe/auth/register.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //Instance of AuthService class
  final AuthService _auth = AuthService();
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
        title: Text('Sign in to BSafe'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            }, 
            icon: Icon(Icons.person), 
            label: Text('Register')
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
                      'Sign in',
                      style: TextStyle(color: Colors.white)
                    ),
                    onPressed: () async {

                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                        if(result == null) {
                          setState(() {
                            error = 'Could not sign in with those credentials';
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
