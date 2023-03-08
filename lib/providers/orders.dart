import 'package:flutter/material.dart';

import 'Cart.dart';

class Order {
  final String id;
  final double amount;
  final List<Cart> products;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class OrderServices with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder(List<Cart> cartProduct, double total) {
    _orders.insert(
        0,
        Order(
            id: DateTime.now().toString(),
            amount: total,
            products: cartProduct,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
