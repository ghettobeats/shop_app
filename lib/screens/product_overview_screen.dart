import 'package:flutter/material.dart';

import '../widget/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
        ),
        body: ProductsGrid(),
      );
}
