import 'package:flutter/material.dart';

import '../model/response_model.dart';

class CartProvider extends ChangeNotifier {
  final List<Param> _cartItems = [];
  int totalPrice = 0;

  List<Param> get cartItems => _cartItems;

  void addItemToCart(item) {
    final index = cartItems.indexWhere((element) => element.id == item.id);
    print('index');
    if (index >= 0) {
      cartItems[index].quantity = cartItems[index].quantity! + 1;
    } else {
      cartItems.add(item);
    }
    getTotalAmount();
    print(cartItems);
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }

  void deleteItemFromCart(item) {
    final index = cartItems.indexWhere((element) => element.id == item.id);
    cartItems.removeAt(index);
    getTotalAmount();
    notifyListeners();
  }

  void increaseQuantity(Param item) {
    item.quantity = item.quantity! + 1;
    getTotalAmount();
    notifyListeners();
  }

  void decreaseQuantity(Param item) {
    if (item.quantity! > 1) {
      item.quantity = item.quantity! - 1;
    } else {
      deleteItemFromCart(item);
    }
    getTotalAmount();
    notifyListeners();
  }

  void getTotalAmount() {
    int price = 0;
    for (var i = 0; i < cartItems.length; i++) {
      price = price + cartItems[i].price! * cartItems[i].quantity!;
    }
    totalPrice = price;
    notifyListeners();
  }
}


