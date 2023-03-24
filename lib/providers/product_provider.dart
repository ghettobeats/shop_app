//este provider se creara para el curso 198 uniendo modelos & providers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  ProductProvider({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = 'flutterrdshop-default-rtdb.firebaseio.com';
    try {
      final response = await http.patch(Uri.https(url, '/products/$id.json'),
          body: jsonEncode({'isFavorite': isFavorite}));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (e) {
      _setFavValue(oldStatus);
    }
  }
}
