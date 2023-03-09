import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';

import '../providers/cart_provider.dart';
import '../widget/appDrawer.dart';
import '../widget/badge.dart';
import '../widget/products_grid.dart';

enum FiltersOptions { Favorite, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavorite = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('My Shop'),
          actions: [
            PopupMenuButton(
                onSelected: (FiltersOptions value) => setState(() {
                      value == FiltersOptions.Favorite
                          ? _showFavorite = true
                          : _showFavorite = false;
                    }),
                child: Icon(Icons.more_vert),
                itemBuilder: (_) => [
                      const PopupMenuItem(
                        child: Text('Favorite'),
                        value: FiltersOptions.Favorite,
                      ),
                      const PopupMenuItem(
                        child: Text('Show All'),
                        value: FiltersOptions.All,
                      )
                    ]),
            Consumer<CartProvider>(
              builder: (_, cart, ch) => Badges(
                value: cart.itemCount.toString(),
                child: ch as Widget,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            )
          ],
        ),
        body: ProductsGrid(_showFavorite),
        drawer: AppDrawer(),
      );
}
