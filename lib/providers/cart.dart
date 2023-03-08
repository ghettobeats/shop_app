import 'package:flutter/foundation.dart';

class CartItem {
  final String id;

  final String title;
  final int quantity;
  final double price;
  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _item = {};

  Map<String, CartItem> get items => {..._item};

  void addItem(String productId, double price, String title) {
    if (_item.containsKey(productId)) {
      _item.update(
          productId,
          (ExistingItem) => CartItem(
              id: ExistingItem.id,
              title: ExistingItem.title,
              quantity: ExistingItem.quantity + 1,
              price: ExistingItem.price));
    } else {
      _item.putIfAbsent(
          productId,
          () => CartItem(
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

  int get itemCount => _item.length;

  double get TotalAmount {
    var total = 0.0;
    _item.forEach((key, value) => total += value.price * value.quantity);
    return total;
  }
}
