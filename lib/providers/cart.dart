import 'package:flutter/foundation.dart';
import 'package:shop_app/models/product.dart';

class Cart {
  final String id;
  final String title;
  final int quantity;
  final double price;
  Cart(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class CartIem with ChangeNotifier {
  Map<String, Cart>? _items;

  Map<String, CartIem> get items => {...items};

  void addItem(String productId, double price, String title) {
    if (_items!.containsKey(productId)) {
      _items!.update(
          productId,
          (ExistingItem) => Cart(
              id: ExistingItem.id,
              title: ExistingItem.title,
              quantity: ExistingItem.quantity + 1,
              price: ExistingItem.price));
    } else {
      _items!.putIfAbsent(
          productId,
          () => Cart(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
  }
}
