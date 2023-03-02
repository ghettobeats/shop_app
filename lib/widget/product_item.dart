import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class ProducItem extends StatelessWidget {
  ProducItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailsScreen.routeName, arguments: id);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            leading: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
              color: Theme.of(context).colorScheme.secondary,
            ),
            trailing: IconButton(
              icon: Icon(Icons.star_rate),
              onPressed: () {},
              color: Theme.of(context).colorScheme.secondary,
            )),
      ),
    );
  }
}
