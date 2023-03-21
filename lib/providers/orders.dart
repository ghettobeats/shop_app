import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cart_provider.dart';

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
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  Future<void> addOrder(List<Cart> cartProduct, double total) async {
    final timestamp = DateTime.now();
    try {
      final respose = await http.post(
        Uri.https('my.api.mockaroo.com', '/order'),
        headers: {'X-API-Key': 'a448f120'},
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProduct
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price
                  })
              .toList()
        }),
      );
      _orders.insert(
        0,
        Order(
          id: DateTime.now().toString(),
          amount: total,
          products: cartProduct,
          dateTime: DateTime.now(),
        ),
      );
      notifyListeners();
    } catch (e) {}
  }
}
