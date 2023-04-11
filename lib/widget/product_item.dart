import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';

import '../providers/auth.dart';
import '../providers/cart_provider.dart';
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
    final cart = Provider.of<CartProvider>(context, listen: false);
    /*en linea puedo usar esta funcionalidad es igual a los providers context.read context.watch example context.read<Auth>().token
      investigar acerca de esto
    */
    final auth = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                  arguments: product.id);
            },
            child: Hero(
              tag: product.id!,
              child: FadeInImage(
                placeholder: AssetImage('assets/images/placeholder.png'),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            )),
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
                      onPressed: () => ProductProvider.toggleFavoriteStatus(
                          context.read<Auth>().token,
                          context.read<Auth>().userId),
                      color: Theme.of(context).colorScheme.secondary,
                    )),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'UNDO',
                    ),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: "REMOVE",
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
              color: Theme.of(context).colorScheme.secondary,
            )),
      ),
    );
  }
}
