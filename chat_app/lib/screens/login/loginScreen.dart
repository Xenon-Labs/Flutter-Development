import 'package:flutter/material.dart';
import 'package:chat_app/services/authentication.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: FlatButton(
        child: Text('Sign in with Google'),
        onPressed: Authentication.handleLogin,
      ),
    ));
  }
}
