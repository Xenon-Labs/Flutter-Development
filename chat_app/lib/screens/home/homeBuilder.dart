import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/services/authentication.dart';
import 'package:provider/provider.dart';

class HomeBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(firebaseUser.displayName),
          FlatButton(
            child: Text('Sign Out'),
            onPressed: Authentication.handleLogout,
          )
        ],
      ),
    );
  }
}
