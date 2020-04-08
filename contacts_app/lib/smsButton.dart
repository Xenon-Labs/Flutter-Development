import 'package:flutter/material.dart';
import 'helperFunctions.dart';

class SmsButton extends StatelessWidget {
  const SmsButton({Key key, @required this.phoneNumbers}) : super(key: key);

  final Iterable phoneNumbers;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.message),
      onPressed: onSmsButtonPressed(context),
    );
  }

  Function onSmsButtonPressed(BuildContext context) {
    String number = HelperFunctions.getValidPhoneNumber(phoneNumbers);
    if (number != null) {
      return () {
        HelperFunctions.messagingDialog(context, number);
      };
    } else {
      return null;
    }
  }
}
