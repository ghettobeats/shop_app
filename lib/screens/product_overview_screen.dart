import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_screen.dart';

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
  bool _init = true;
  bool _isloading = true;
  @override
  void initState() {
    // Provider.of<ProductServices>(context).fetchAndsetData(); Wont work!
    // Future.delayed(Duration.zero).then((value) {
    //   Provider.of<ProductServices>(context).fetchAndsetData();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _isloading = true;
      });
      Provider.of<ProductServices>(context, listen: false)
          .fetchAndsetData()
          .then(
            (_) => setState(() {
              _isloading = false;
            }),
          );
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('My Shop'),
          actions: [
            PopupMenuButton(
                child: const Icon(Icons.more_vert),
                onSelected: (FiltersOptions value) => setState(() {
                      value == FiltersOptions.Favorite
                          ? _showFavorite = true
                          : _showFavorite = false;
                    }),
                itemBuilder: (_) => [
                      PopupMenuItem(
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
        body: _isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(_showFavorite),
        drawer: AppDrawer(),
      );
}
