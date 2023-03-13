import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widget/appDrawer.dart';

import '../providers/products.dart';
import '../widget/user_product_item.dart';
import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName,
                  arguments: {'id': 'p8'});
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: products.items.length,
            itemBuilder: (_, index) => Column(
                  children: [
                    UserProductItem(products.items[index].title,
                        products.items[index].imageUrl),
                    Divider(),
                  ],
                )),
      ),
    );
  }
}
