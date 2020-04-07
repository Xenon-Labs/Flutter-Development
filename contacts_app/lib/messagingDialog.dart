import 'package:flutter/material.dart';

class MessagingDialog extends StatefulWidget {
  MessagingDialog({Key key, this.confirmCallback, this.recipient})
      : super(key: key);

  final Function confirmCallback;
  final String recipient;

  @override
  _MessagingDialogState createState() => _MessagingDialogState();
}

class _MessagingDialogState extends State<MessagingDialog> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Enter Message"),
      content: TextFormField(controller: controller),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            widget.confirmCallback(context, controller.text, widget.recipient);
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
