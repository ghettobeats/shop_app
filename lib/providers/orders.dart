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

  List<Order> get orders => [..._orders];

  Future<void> fetchAndSetOrder() async {
    const url = 'my.api.mockaroo.com';
    final response = await http
        .get(Uri.https(url, '/order'), headers: {'X-API-Key': 'a448f120'});
    final List<Order> loaderOrders = [];
    //no hago nada poque mi enpoint no me devuelve un map y no quise joder con esto
    //asi que debo buscar la forma de tambien hacerlo con una lista
    //final extractedData = json.decode(response.body) as Map<String, dynamic>;
    // if (extractedData == null) {
    //   retun;
    // }
    //   extractedData.forEach((key,orderData) {
    //   loaderOrders.add(
    //     Order(
    //       id: key,
    //       amount: orderData['amount'],
    //       dateTime: DateTime.parse(orderData['dateTime']),
    //       products: (orderData['product'] as List<dynamic>)
    //           .map((item) => Cart(
    //               id: item['id'],
    //               title: item['title'],
    //               price: item['price'],
    //               quantity: item['quantity']))
    //           .toList(),
    //     ),
    //   );
    // });

    _orders = loaderOrders.reversed.toList();
    notifyListeners();
  }

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
