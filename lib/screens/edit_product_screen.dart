import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(children: [
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Title', hintText: 'Write Some Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Price', hintText: 'Write Some Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
            ),
          ]),
        ),
      ),
    );
  }
}
