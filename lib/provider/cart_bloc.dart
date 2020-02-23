import 'package:flutter/material.dart';

class CartBloc with ChangeNotifier {
  Map<int, int> _cart = {};

  Map<int, int> get cart => _cart;

  void addToCart(index) {
    print("index in cart $index");
    if (_cart.containsKey(index)) {
      _cart[index] += 1;
    } else {
      _cart[index] = 1;
    }
    notifyListeners();
  }

  void deleteToCart(index) {
    if (_cart.containsKey(index)) {
      _cart[index] -= 1;
      if (_cart[index] < 1) {
        _cart[index] = 1;
        // _cart.remove(index);
        notifyListeners();
      }
    } else {
      _cart[index] = 1;
    }
    notifyListeners();
  }

  void clear(index) {
    if (_cart.containsKey(index)) {
      _cart.remove(index);
      notifyListeners();
    }
  }

  void clearAll(allItemInCart) {
    for (var i in allItemInCart) {
      print("this value i is $i");
      _cart.remove(i);
    }
    print("clear");
    notifyListeners();
  }
}
