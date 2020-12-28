import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/screens/messaging/newMessageScreen.dart';

class NewMessageProvider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<User>>.value(
      value: Database.streamUsers(),
      child: NewMessageScreen(),
    );
  }
}
