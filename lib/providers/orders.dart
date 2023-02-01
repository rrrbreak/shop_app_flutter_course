import 'package:flutter/material.dart';

import '../screens/cart_item.dart';
// define how order should look like

// class OrderItem {
//   final String id;
//   final double amount;
//   final List<CartItem> products;
//   final DateTime dateTime;

//   OrderItem({
//     @required this.id,
//     @required this.amount,
//     @required this.products,
//     @required this.dateTime,
//   });
// }

// class Orders with ChangeNotifier {
//   List<OrderItem> _orders = [];

//   List<OrderItem> get orders {
//     return [..._orders];
//   }

//   void addOrder(List<CartItem> cartProducts, double total) {
//     // 0 in insert means recent order will be at the beggining of the list
//     _orders.insert(
//       0,
//       OrderItem(
//         id: DateTime.now().toString(),
//         amount: total,
//         products: cartProducts,
//         dateTime: DateTime.now(),
//       ),
//     );
//     notifyListeners();
//   }
// }

class OrderItem {
  final String id;
  final double amount;
  final DateTime dateTime;
  final List<CartItem> products;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.dateTime,
    @required this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
