import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  static final Firestore _db = Firestore.instance;

  static Future<void> addUser(FirebaseUser user) async {
    await _db.collection('users').document(user.uid).setData(
        {'id': user.uid, 'name': user.displayName, 'email': user.email});
  }
}
