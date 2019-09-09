import 'package:flutter/material.dart';


class CounterModel extends ChangeNotifier {
  int value = 0;

  void increase() {
    value ++;
    notifyListeners();
  }
}