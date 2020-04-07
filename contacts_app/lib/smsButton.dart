import 'package:flutter/material.dart';
import 'helperFunctions.dart';

class SmsButton extends StatefulWidget {
  const SmsButton({Key key, @required this.phoneNumbers}) : super(key: key);

  final Iterable phoneNumbers;

  @override
  _SmsButtonState createState() => _SmsButtonState();
}

class _SmsButtonState extends State<SmsButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.message),
      onPressed: () {
        if (widget.phoneNumbers != null &&
            widget.phoneNumbers.toList().isNotEmpty) {
          List phoneNumbersList = widget.phoneNumbers.toList();
          // This messages first available number
          // Can change this to display all numbers first and let the user
          // choose which one to send sms to.
          if (phoneNumbersList[0].value != null) {
            HelperFunctions.messagingDialog(context, phoneNumbersList[0].value);
          }
        }
      },
    );
  }
}
