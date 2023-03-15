import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/product_provider.dart';

class ProductServices with ChangeNotifier {
  final List<ProductProvider> _item = [
    ProductProvider(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    ProductProvider(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    ProductProvider(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    ProductProvider(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<ProductProvider> get items => [..._item];

  List<ProductProvider> get favoritesItems =>
      _item.where((element) => element.isFavorite).toList();

  ProductProvider findById(String id) => _item.firstWhere((e) => e.id == id);

  //bool Exist(String id) => _item.any((element) => element.id == id);

//Future
  Future<void> addProduct(ProductProvider product) {
    const Url = 'fakestoreapi.com';
    return http
        .post(
      Uri.https(Url, '/products'),
      body: json.encode({
        'price': product.price,
        'description': product.description,
        'image': product.imageUrl,
        'category': "women's clothing",
      }),
    )
        .then((value) {
      final newProduct = ProductProvider(
          id: DateTime.now().toString(),
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _item.add(newProduct);
      notifyListeners();
    }).onError((error, stackTrace) {});
  }

  void updateProduct(String id, ProductProvider newProduct) {
    final prodIndex = _item.indexWhere((element) => element.id == id);

    if (prodIndex >= 0) {
      _item[prodIndex] = newProduct;

      notifyListeners();
    } else {
      print('');
    }
  }

  deleteProduct(String id) {
    _item.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
