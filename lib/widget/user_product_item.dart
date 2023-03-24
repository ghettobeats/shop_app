import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String? id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final scaffoldMessage = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName, arguments: id);
                  }),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await Provider.of<ProductServices>(context, listen: false)
                        .deleteProduct(id);
                  } catch (e) {
                    scaffoldMessage.showSnackBar(
                        SnackBar(content: Text('Deleting failed')));
                  }
                },
              )
            ],
          )),
    );
  }
}
