import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier {
  int counter;
  CounterProvider({this.counter});

  reset() {
    counter = 0;
    notifyListeners();
  }

  increment() {
    counter++;
    notifyListeners();
  }

  delete() {
    if (counter > 0) {
      counter--;
    } else {
      return 0;
    }
    notifyListeners();
  }
}
