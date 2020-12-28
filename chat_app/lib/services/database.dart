import 'dart:async';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/convo.dart';

class Database {
  static final Firestore _db = Firestore.instance;

  static Future<void> addUser(FirebaseUser user) async {
    await _db.collection('users').document(user.uid).setData(
        {'id': user.uid, 'name': user.displayName, 'email': user.email});
  }

  static Stream<List<User>> streamUsers() {
    return _db
        .collection('users')
        .snapshots()
        .map((QuerySnapshot list) => list.documents
            .map((DocumentSnapshot snap) => User.fromMap(snap.data))
            .toList())
        .handleError((dynamic e) {
      print(e);
    });
  }

  static Stream<List<User>> getUsersByList(List<String> userIds) {
    final List<Stream<User>> streams = List();
    for (String id in userIds) {
      streams.add(_db
          .collection('users')
          .document(id)
          .snapshots()
          .map((DocumentSnapshot snap) => User.fromMap(snap.data)));
    }
    return StreamZip<User>(streams).asBroadcastStream();
  }

  static Stream<List<Convo>> streamConversations(String uid) {
    return _db
        .collection('messages')
        .orderBy('lastMessage.timestamp', descending: true)
        .where('users', arrayContains: uid)
        .snapshots()
        .map((QuerySnapshot list) => list.documents
            .map((DocumentSnapshot doc) => Convo.fromFireStore(doc))
            .toList());
  }

  static void sendMessage(
    String convoID,
    String id,
    String pid,
    String content,
    String timestamp,
  ) {
    final DocumentReference convoDoc =
        Firestore.instance.collection('messages').document(convoID);

    convoDoc.setData(<String, dynamic>{
      'lastMessage': <String, dynamic>{
        'idFrom': id,
        'idTo': pid,
        'timestamp': timestamp,
        'content': content,
        'read': false
      },
      'users': <String>[id, pid]
    }).then((dynamic success) {
      final DocumentReference messageDoc = Firestore.instance
          .collection('messages')
          .document(convoID)
          .collection(convoID)
          .document(timestamp);

      Firestore.instance.runTransaction((Transaction transaction) async {
        await transaction.set(
          messageDoc,
          <String, dynamic>{
            'idFrom': id,
            'idTo': pid,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'read': false
          },
        );
      });
    });
  }

  static void updateMessageRead(DocumentSnapshot doc, String convoID) {
    final DocumentReference documentReference = Firestore.instance
        .collection('messages')
        .document(convoID)
        .collection(convoID)
        .document(doc.documentID);

    documentReference.setData(<String, dynamic>{'read': true}, merge: true);
  }

  static void updateLastMessage(
      DocumentSnapshot doc, String uid, String pid, String convoID) {
    final DocumentReference documentReference =
        Firestore.instance.collection('messages').document(convoID);

    documentReference
        .setData(<String, dynamic>{
          'lastMessage': <String, dynamic>{
            'idFrom': doc['idFrom'],
            'idTo': doc['idTo'],
            'timestamp': doc['timestamp'],
            'content': doc['content'],
            'read': doc['read']
          },
          'users': <String>[uid, pid]
        })
        .then((dynamic success) {})
        .catchError((dynamic error) {
          print(error);
        });
  }
}
