import 'package:flutter/material.dart';
import 'helperFunctions.dart';

class PhoneButton extends StatelessWidget {
  const PhoneButton({Key key, @required this.phoneNumbers}) : super(key: key);

  final Iterable phoneNumbers;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.phone),
      onPressed: onPhoneButtonPressed(context),
    );
  }

  Function onPhoneButtonPressed(BuildContext context) {
    String number = HelperFunctions.getValidPhoneNumber(phoneNumbers);
    if (number != null) {
      return () {
        HelperFunctions.callNumber(context, number);
      };
    } else {
      return null;
    }
  }
}
