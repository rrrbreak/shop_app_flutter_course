import 'package:flutter/material.dart';

// Defining how Cart should look like
class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    this.id,
    this.title,
    this.quantity,
    this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.00;
    _items.forEach(
      (key, cartItem) {
        total += cartItem.price * cartItem.quantity;
      },
    );
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      // change quantity
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
          title: existingCartItem.title,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    ;
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
