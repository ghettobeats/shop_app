import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

import '../widget/products_grid.dart';

enum FiltersOptions { Favorite, All }

class ProductOverviewScreen extends StatelessWidget {
  bool _showFavorite = false;

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
              onSelected: (FiltersOptions value) =>
                  value == FiltersOptions.Favorite
                      ? productData.showFavoritesOnly()
                      : productData.showAll(),
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
                  ])
        ],
      ),
      body: ProductsGrid(_showFavorite),
    );
  }
}
