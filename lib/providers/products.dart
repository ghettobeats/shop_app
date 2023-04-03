import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/product_provider.dart';
import 'auth.dart';

class ProductServices with ChangeNotifier {
  final Auth authentication;

  List<ProductProvider> _item = [
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

  ProductServices(
    this.authentication,
    this._item,
  );

  List<ProductProvider> get items => [..._item];

  List<ProductProvider> get favoritesItems =>
      _item.where((element) => element.isFavorite).toList();

  ProductProvider findById(String id) => _item.firstWhere((e) => e.id == id);

  //bool Exist(String id) => _item.any((element) => element.id == id);

//[bool filter = false] opcional argument
  Future<void> fetchAndsetData([bool filter = false]) async {
    //const url = 'flutterrdshop-default-rtdb.firebaseio.com';
    final filtering =
        filter ? 'orderBy="creatorId"&equalTo="${authentication.userId}"' : '';

    var urls = Uri.parse(
        'https://flutterrdshop-default-rtdb.firebaseio.com/products.json?auth=${authentication.token}&$filtering');
    try {
      // final response =
      //     await http.get(Uri.https(url, '/products.json?auth=$authToken'));
      final response = json.decode((await http.get(urls)).body);
      if (response == 'null') {
        return;
      }
      urls = Uri.parse(
          'https://flutterrdshop-default-rtdb.firebaseio.com/userFavorites/${authentication.userId}.json?auth=${authentication.token}');
      var favoriteResponse = json.decode((await http.get(urls)).body);
      var extractedData = response as Map<String, dynamic>;
      final List<ProductProvider> loadedProduct = [];

      extractedData.forEach((key, value) {
        loadedProduct.add(ProductProvider(
            id: key,
            title: value['title'],
            description: value['description'],
            price: double.parse(value['price'].toString()),
            isFavorite: favoriteResponse == null
                ? false
                : favoriteResponse[key] ?? false,
            imageUrl: value['image']));

        _item = loadedProduct;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

//Future
  Future<void> addProduct(ProductProvider product) async {
    // const url = 'flutterrdshop-default-rtdb.firebaseio.com';
    final urls = Uri.parse(
        "https://flutterrdshop-default-rtdb.firebaseio.com/products.json?auth=${authentication.token}");
    try {
      // final response = await http.post(
      //   Uri.https(url, '/products.json?auth=${authentication.token}'),
      final response = await http.post(
        urls,
        body: json.encode({
          'title': product.title,
          'price': product.price,
          'description': product.description,
          'image': product.imageUrl,
          'creatorId': authentication.userId
        }),
      );
      final newProduct = ProductProvider(
          id: json.decode(response.body)['name'],
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

  Future<void> updateProduct(String? id, ProductProvider newProduct) async {
    final prodIndex = _item.indexWhere((element) => element.id == id);

    if (prodIndex >= 0) {
      final urls = Uri.parse(
          "https://flutterrdshop-default-rtdb.firebaseio.com/products/$id.json?auth=${authentication.token}");
      // const url = 'flutterrdshop-default-rtdb.firebaseio.com';
      final response = await http.patch(
        urls,
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

  Future<void> deleteProduct(String? id) async {
    final urls = Uri.parse(
        "https://flutterrdshop-default-rtdb.firebaseio.com/products/$id.json?auth=${authentication.token}");
    // const url = 'flutterrdshop-default-rtdb.firebaseio.com';
    final existingProductIndex = _item.indexWhere((prod) => prod.id == id);
    var existingProduct = _item[existingProductIndex];
    _item.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(urls);
    if (response.statusCode >= 400) {
      _item.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = ProductProvider(
        id: null, title: '', description: '', price: 00.00, imageUrl: '');
  }
}
