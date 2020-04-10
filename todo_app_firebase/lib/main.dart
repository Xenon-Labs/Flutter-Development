import 'package:flutter/material.dart';
import 'package:todo_app_firebase/widgets/edit_dialog.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'To-Do List', home: new TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => new _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todoList = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text('To-Do List')),
        body: _getFirestoreValues(),
        floatingActionButton: new FloatingActionButton(
            onPressed: () => _displayDialog(context),
            tooltip: 'Add Item',
            child: new Icon(Icons.add)));
  }

  _getFirestoreValues() {
    // TODO: Stream Database Values
  }

  // Display Add Task Dialog
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return EditDialog(
              title: 'Add Task',
              positiveAction: 'ADD',
              negativeAction: 'CANCEL');
        });
  }

  void showInSnackBar(String value, String actionText) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(value),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: actionText,
        onPressed: scaffold.hideCurrentSnackBar,
      ),
    ));
  }
}
