import 'package:flutter/material.dart';

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
                    ])
          ],
        ),
        body: ProductsGrid(_showFavorite),
      );
}
