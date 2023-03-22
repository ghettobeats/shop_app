import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/product_provider.dart';

class ProductServices with ChangeNotifier {
  final List<ProductProvider> _item = [
    // ProductProvider(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // ProductProvider(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // ProductProvider(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // ProductProvider(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<ProductProvider> get items => [..._item];

  List<ProductProvider> get favoritesItems =>
      _item.where((element) => element.isFavorite).toList();

  ProductProvider findById(String id) => _item.firstWhere((e) => e.id == id);

  //bool Exist(String id) => _item.any((element) => element.id == id);
  Future<void> fetchAndsetData() async {
    const url = 'my.api.mockaroo.com';
    try {
      final response = await http
          .get(Uri.https(url, '/product'), headers: {'X-API-Key': 'a448f120'});
      var extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((value) {
        _item.add(ProductProvider(
            id: value['id'].toString(),
            title: value['title'],
            description: value['description'],
            price: double.parse(value['price'].toString()),
            imageUrl: value['imageUrl']));

        notifyListeners();
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

//Future
  Future<void> addProduct(ProductProvider product) async {
    const Url = 'my.api.mockaroo.com';
    try {
      final response = await http.post(
        Uri.https(Url, '/products'),
        headers: {'X-API-Key': 'a448f120'},
        body: json.encode({
          'title': product.title,
          'price': product.price,
          'description': product.description,
          'image': product.imageUrl,
        }),
      );
      final newProduct = ProductProvider(
          id: DateTime.now().toString(),
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _item.add(newProduct);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProduct(String id, ProductProvider newProduct) async {
    final prodIndex = _item.indexWhere((element) => element.id == id);

    if (prodIndex >= 0) {
      final Url = 'my.api.mockaroo.com';
      final response = await http.patch(
        Uri.https(Url, '/products/$id'),
        headers: {'X-API-Key': 'a448f120'},
        body: json.encode({
          'title': newProduct.title,
          'price': newProduct.price,
          'description': newProduct.description,
          'image': newProduct.imageUrl,
        }),
      );
      _item[prodIndex] = newProduct;

      notifyListeners();
    } else {
      print('');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'my.api.mockaroo.com';
    final existingProductIndex = _item.indexWhere((prod) => prod.id == id);
    var existingProduct = _item[existingProductIndex];
    _item.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(Uri.https(url, '/product.json/$id'),
        headers: {'X-API-Key': 'a448f120'});

    if (response.statusCode >= 400) {
      _item.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = ProductProvider(
        id: '', title: '', description: '', price: 00.00, imageUrl: '');
  }
}
