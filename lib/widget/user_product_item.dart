import 'package:flutter/material.dart';

import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title, imageUrl;

  UserProductItem(this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
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
                    Navigator.of(context).pushNamed(EditProductScreen.routeName,
                        arguments: {'id': 'p1'});
                  }),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              ),
            ],
          )),
    );
  }
}
