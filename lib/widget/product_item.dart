import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';

import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class ProducItem extends StatelessWidget {
  // ProducItem({
  //   required this.id,
  //   required this.title,
  //   required this.imageUrl,
  // });

  // final String id;
  // final String title;
  // final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            leading: IconButton(
              icon: Icon(product.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined),
              onPressed: () => product.toggleFavoriteStatus(),
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