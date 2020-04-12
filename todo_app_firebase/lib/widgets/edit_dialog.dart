import 'package:flutter/material.dart';

typedef VoidCallback = Function(String value);

class EditDialog extends StatefulWidget {
  const EditDialog(
      {@required this.title,
      @required this.positiveAction,
      @required this.negativeAction,
      @required this.submit});
  final String title, positiveAction, negativeAction;
  final VoidCallback submit;

  EditDialogState createState() => EditDialogState();
}

class EditDialogState extends State<EditDialog> {
  final TextEditingController textFieldController = TextEditingController();
  bool _validateDialog = true;

  @override
  void initState() {
    textFieldController.addListener(_updateDialogTextField);
    super.initState();
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

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
              widget.submit(textFieldController.text.toString());
              Navigator.of(context).pop();
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
}
