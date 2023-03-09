import 'package:flutter/material.dart';

class Cart {
  final String id;

  final String title;
  final int quantity;
  final double price;
  Cart({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, Cart> _item = {};

  Map<String, Cart> get items => {..._item};

  int get itemCount => _item.length;

  double get TotalAmount {
    var total = 0.0;
    _item.forEach((key, value) => total += value.price * value.quantity);
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_item.containsKey(productId)) {
      _item.update(
          productId,
          (ExistingItem) => Cart(
              id: ExistingItem.id,
              title: ExistingItem.title,
              quantity: ExistingItem.quantity + 1,
              price: ExistingItem.price));
    } else {
      _item.putIfAbsent(
          productId,
          () => Cart(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _item.remove(id);
    notifyListeners();
  }

  void clear() {
    _item.clear();
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_item.containsKey(id)) {
      return;
    }
    if (_item[id]!.quantity > 1) {
      _item.update(
          id,
          (existing) => Cart(
              id: existing.id,
              title: existing.title,
              price: existing.price,
              quantity: existing.quantity - 1));
    } else {
      _item.remove(id);
    }
    notifyListeners();
  }
}
