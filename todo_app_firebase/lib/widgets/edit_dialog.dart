import 'package:flutter/material.dart';

class EditDialog extends StatefulWidget {
  const EditDialog(
      {@required this.title,
      @required this.positiveAction,
      @required this.negativeAction});
  final String title, positiveAction, negativeAction;

  EditDialogState createState() => EditDialogState();
}

class EditDialogState extends State<EditDialog> {
  final TextEditingController textFieldController = new TextEditingController();
  bool _validateDialog = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: getDialogContent(),
      actions: <Widget>[
        FlatButton(
          child: Text(widget.positiveAction,
              style: TextStyle(
                color: _validateDialog ? Colors.blueAccent : Colors.grey,
              )),
          onPressed: () {
            if (_validateDialog) {
              // TODO: Update Database
            }
          },
        ),
        FlatButton(
          child: Text(
            widget.negativeAction,
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  @override
  void initState() {
    textFieldController.addListener(_updateDialogTextField);
    super.initState();
  }

  Widget getDialogContent() {
    return TextField(
      cursorColor: Theme.of(context).accentColor,
      controller: textFieldController,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: 'Enter your task here',
        errorText: !_validateDialog ? 'Value Can\'t Be Empty' : null,
      ),
    );
  }


  void _updateDialogTextField() {
    setState(() {
      _validateDialog = textFieldController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }
}
