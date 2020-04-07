import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';
import 'messagingDialog.dart';

class HelperFunctions {
  static Future<void> initiateMessage(
      BuildContext context, String message, String recipient) async {
    final String _result =
        await sendSMS(message: message, recipients: <String>[recipient])
            .catchError((dynamic onError) {
      print(onError);
      standardAlertDialog(context, "Error", onError.toString());
    });
    print(_result);
  }

  static Future<void> callNumber(BuildContext context, String number) async {
    bool _result =
        await launch('tell://' + number).catchError((dynamic onError) {
      print(onError);
      standardAlertDialog(context, "Error", onError.toString());
    });
    if (_result == false) {
      standardAlertDialog(context, "Error", "Can not call on this device");
    }
  }

  static String hasValidPhoneNumber(Iterable phoneNumbers) {
    if (phoneNumbers != null && phoneNumbers.toList().isNotEmpty) {
      List phoneNumbersList = phoneNumbers.toList();
      // This messages first available number
      // Can change this to display all numbers first and let the user
      // choose which one to send sms to.
      return phoneNumbersList[0].value;
    }
    return null;
  }

  // Used for error messages
  static void standardAlertDialog(
      BuildContext context, String title, String content) {
    showDialog<Dialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: content.isNotEmpty ? Text(content) : null,
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  static void messagingDialog(BuildContext context, String recipient) {
    showDialog<Dialog>(
        context: context,
        builder: (BuildContext context) {
          return MessagingDialog(
              confirmCallback: initiateMessage, recipient: recipient);
        });
  }
}
