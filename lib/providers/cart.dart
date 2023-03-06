import 'package:flutter/foundation.dart';

class CartIem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartIem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  late final Map<String, CartIem> _items = {};

  Map<String, CartIem> get items => {...items};

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (ExistingItem) => CartIem(
              id: ExistingItem.id,
              title: ExistingItem.title,
              quantity: ExistingItem.quantity + 1,
              price: ExistingItem.price));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartIem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  int get itemCount => _items.length;

  double get TotalAmount {
    var total = 0.0;
    _items.forEach((key, value) => total += value.price * value.quantity);
    return total;
  }
}
