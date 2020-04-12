import 'package:flutter/material.dart';
import 'package:todo_app_firebase/services/database.dart';
import 'package:todo_app_firebase/widgets/edit_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_firebase/widgets/task.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'To-Do List',
        home: TodoList(),
        debugShowCheckedModeBanner: false);
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('To-Do List')),
        body: _getTasks(),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _displayDialog(context),
            tooltip: 'Add Item',
            child: Icon(Icons.add)));
  }

  // Display Add Task Dialog
  Future<void> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return EditDialog(
              title: 'Add Task',
              positiveAction: 'ADD',
              negativeAction: 'CANCEL',
              submit: _handleDialogSubmission);
        });
  }

  // Add Task
  void _handleDialogSubmission(String value) {
    var task = <String, dynamic>{
      'content': value,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    };
    Database.addTask(task);
  }

  // Retrieve Tasks
  Widget _getTasks() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('tasks')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (BuildContext context, int index) => Task(
                  content: snapshot.data.documents[index]['content'],
                  id: snapshot.data.documents[index].documentID,
                  update: _updateTask,
                  delete: _deleteTask),
              itemCount: snapshot.data.documents.length,
            );
          } else {
            return Container();
          }
        });
  }

  void _updateTask(String updatedValue, String id) {
    var task = <String, dynamic>{
      'content': updatedValue,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    };
    Database.updateTask(id, task);
  }

  void _deleteTask(String id) {
    Database.deleteTask(id);
  }
}
