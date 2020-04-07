import 'package:flutter/material.dart';
import 'helperFunctions.dart';

class PhoneButton extends StatelessWidget {
  const PhoneButton({Key key, @required this.phoneNumbers}) : super(key: key);

  final Iterable phoneNumbers;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.phone),
      onPressed: () {
        String number = HelperFunctions.hasValidPhoneNumber(phoneNumbers);
        if (number != null) {
          HelperFunctions.callNumber(context, number);
        }
      },
    );
  }
}
