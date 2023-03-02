import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  // final String title;

  // const ProductDetailsScreen({super.key, required this.title});
  static const routeName = '/productdetails';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(productId),
      ),
    );
  }
}
