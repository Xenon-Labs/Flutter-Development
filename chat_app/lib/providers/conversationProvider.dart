import 'package:chat_app/models/convo.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/screens/home/homeBuilder.dart';
import 'package:chat_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationProvider extends StatelessWidget {
  const ConversationProvider({
    Key key,
    @required this.user,
  }) : super(key: key);

  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Convo>>.value(
        value: Database.streamConversations(user.uid),
        child: ConversationDetailsProvider(user: user));
  }
}

class ConversationDetailsProvider extends StatelessWidget {
  const ConversationDetailsProvider({
    Key key,
    @required this.user,
  }) : super(key: key);

  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<User>>.value(
        value: Database.getUsersByList(
            getUserIds(Provider.of<List<Convo>>(context))),
        child: HomeBuilder());
  }

  List<String> getUserIds(List<Convo> _convos) {
    final List<String> users = <String>[];
    if (_convos != null) {
      for (Convo c in _convos) {
        c.userIds[0] != user.uid
            ? users.add(c.userIds[0])
            : users.add(c.userIds[1]);
      }
    }
    return users;
  }
}