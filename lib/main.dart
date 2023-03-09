import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';

import './screens/cart_screen.dart';
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';

import 'providers/orders.dart';
import 'screens/edit_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //el ultimo es diferente porque los dos primeros son los recomendados pero se puede usar con value
        ChangeNotifierProvider(create: (ctx) => ProductServices()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider.value(value: OrderServices())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData().copyWith(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(secondary: Colors.deepOrange, primary: Colors.purple),
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    );
  }
}
