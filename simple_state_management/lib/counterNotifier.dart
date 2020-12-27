import 'package:flutter/material.dart';

class CounterNotifier extends ChangeNotifier {
  CounterNotifier() {
    counterDateTime = List<DateTime>();
  }
  List<DateTime> counterDateTime;

  void addDateTime(DateTime dateTime) {
    counterDateTime.add(dateTime);
    notifyListeners();
  }
}
