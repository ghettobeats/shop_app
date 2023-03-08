import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';

import '../providers/Cart.dart';
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
    final cart = Provider.of<Cart>(context, listen: false);
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
            leading: Consumer<ProductProvider>(
                builder: (ctx, ProductProvider, child) => IconButton(
                      icon: Icon(ProductProvider.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined),
                      onPressed: () => ProductProvider.toggleFavoriteStatus(),
                      color: Theme.of(context).colorScheme.secondary,
                    )),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
              },
              color: Theme.of(context).colorScheme.secondary,
            )),
      ),
    );
  }
}
