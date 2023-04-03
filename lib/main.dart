import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/screens/auth_screen.dart';
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
          //ChangeNotifierProvider(create: (ctx) => ProductServices("", [])),
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, ProductServices>(
            create: (ctx) => ProductServices(Auth(), []),
            update: (context, auth, previous) =>
                ProductServices(auth, previous == null ? [] : previous.items),
          ),
          ChangeNotifierProvider(create: (ctx) => CartProvider()),
          ChangeNotifierProxyProvider<Auth, OrderServices>(
            create: (ctx) => OrderServices("", [], ""),
            update: (context, auth, previous) => OrderServices(auth.token,
                previous == null ? [] : previous.orders, auth.userId),
          )
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop App',
            theme: ThemeData().copyWith(
              colorScheme: ThemeData().colorScheme.copyWith(
                  secondary: Colors.deepOrange, primary: Colors.purple),
            ),
            home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
            routes: {
              ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrderScreen.routeName: (ctx) => OrderScreen(),
              UserProductScreen.routeName: (ctx) => UserProductScreen(),
              EditProductScreen.routeName: (context) => EditProductScreen(),
            },
          ),
        ));
  }
}
