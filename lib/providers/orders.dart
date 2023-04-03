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
  List<Order> _orders = [];
  String token;
  String userId;

  OrderServices(this.token, this._orders, this.userId);
  List<Order> get orders => [..._orders];

  Future<void> fetchAndSetOrder() async {
    final url = Uri.parse(
        'https://flutterrdshop-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token');
    final response = await http.get(url);
    final List<Order> loaderOrders = [];

    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((key, orderData) {
      loaderOrders.add(
        Order(
          id: key,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => Cart(
                  id: item['id'],
                  title: item['title'],
                  price: item['price'],
                  quantity: item['quantity']))
              .toList(),
        ),
      );
    });

    _orders = loaderOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<Cart> cartProduct, double total) async {
    final url = Uri.parse(
        'https://flutterrdshop-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token');
    final timestamp = DateTime.now();
    try {
      final response = await http.post(
        url,
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
          dateTime: json.decode(response.body)['name'],
        ),
      );
      notifyListeners();
    } catch (e) {}
  }
}
