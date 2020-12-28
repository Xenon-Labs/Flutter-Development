import 'package:cloud_firestore/cloud_firestore.dart';

class Convo {
  Convo({this.id, this.userIds, this.lastMessage});

  factory Convo.fromFireStore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data;

    return Convo(
        id: doc.documentID,
        userIds: data['users'] ?? <dynamic>[],
        lastMessage: data['lastMessage'] ?? <dynamic>{}
    );
  }

  String id;
  List<dynamic> userIds;
  Map<dynamic, dynamic> lastMessage;
}

class Message {
  Message({this.id, this.content, this.idFrom, this.idTo, this.timestamp});

  factory Message.fromFireStore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data;

    return Message(
      id: doc.documentID,
      content: data['content'],
      idFrom: data['idFrom'],
      idTo: data['idTo'],
      timestamp: data['timestamp']
    );
  }

  String id;
  String content;
  String idFrom;
  String idTo;
  DateTime timestamp;
}
