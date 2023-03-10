import 'package:flutter/material.dart';

import '../models/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _product = Product(
      id: '',
      title: '',
      description: '',
      imageUrl: '',
      isFavorite: false,
      price: 0.0);

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    _imageFocusNode.removeListener(_updateImageUrl);

    super.dispose();
  }

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    if (_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    print(_product.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(children: [
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Title', hintText: 'Title...'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              validator: (value) {
                if (value == '') {
                  return 'El campo esta';
                }
                return null;
              },
              onSaved: (value) {
                _product = Product(
                    id: '',
                    title: value!,
                    description: _product.description,
                    price: _product.price,
                    imageUrl: _product.imageUrl);
              },
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Price', hintText: '50.00'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              onSaved: (value) {
                _product = Product(
                    id: '',
                    title: _product.title,
                    description: _product.description,
                    price: double.parse(value!),
                    imageUrl: _product.imageUrl);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Description', hintText: 'Descriptions...'),
              textInputAction: TextInputAction.next,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              onSaved: (value) {
                _product = Product(
                    id: '',
                    title: _product.title,
                    description: value!,
                    price: _product.price,
                    imageUrl: _product.imageUrl);
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.only(
                    top: 8,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: _imageUrlController.text.isEmpty
                      ? Container(
                          child: Text('Select ImageUrl'),
                        )
                      : FittedBox(
                          child: Image.network(_imageUrlController.text),
                          fit: BoxFit.fill,
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'image url'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageFocusNode,
                    onFieldSubmitted: (_) => _saveForm(),
                    onSaved: (value) {
                      _product = Product(
                          id: '',
                          title: _product.title,
                          description: value!,
                          price: _product.price,
                          imageUrl: value);
                    },
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
