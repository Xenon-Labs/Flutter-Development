import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static final Firestore _db = Firestore.instance;

  static Future<void> addTask(Map<String, dynamic> task) async {
    await _db.collection('tasks').document().setData(task).catchError((e) {
      print(e);
    });
  }

  static Future<void> updateTask(String id, Map<String, dynamic> task) async {
    await _db.collection('tasks').document(id).updateData(task).catchError((e) {
      print(e);
    });
  }

  static Future<void> deleteTask(String id) async {
    await _db.collection('tasks').document(id).delete().catchError((e) {
      print(e);
    });
  }
}
