import 'package:chat_app/models/convo.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/providers/newMessageProvider.dart';
import 'package:chat_app/screens/messaging/widgets/convoWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/services/authentication.dart';
import 'package:provider/provider.dart';

class HomeBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
    final List<Convo> _convos = Provider.of<List<Convo>>(context);
    final List<User> _users = Provider.of<List<User>>(context);
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
              onPressed: Authentication.handleLogout,
              icon: Icon(Icons.first_page, size: 30)),
          Text(firebaseUser.displayName, style: TextStyle(fontSize: 18)),
          IconButton(
              onPressed: () => createNewConvo(context),
              icon: Icon(Icons.add, size: 30))
        ],
      )),
      body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: getWidgets(context, firebaseUser, _convos, _users))
    );
  }

  void createNewConvo(BuildContext context) {
    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => NewMessageProvider()));
  }

  Map<String, User> getUserMap(List<User> users) {
    final Map<String, User> userMap = Map();
    for (User u in users) {
      userMap[u.id] = u;
    }
    return userMap;
  }

  List<Widget> getWidgets(
      BuildContext context, FirebaseUser user, List<Convo> _convos, List<User> _users) {
    final List<Widget> list = <Widget>[];
    if (_convos != null && _users != null && user != null) {
      final Map<String, User> userMap = getUserMap(_users);
      for (Convo c in _convos) {
        if (c.userIds[0] == user.uid) {
          list.add(ConvoListItem(
              user: user,
              peer: userMap[c.userIds[1]],
              lastMessage: c.lastMessage));
        } else {
          list.add(ConvoListItem(
              user: user,
              peer: userMap[c.userIds[0]],
              lastMessage: c.lastMessage));
        }
      }
    }

    return list;
  }
}
