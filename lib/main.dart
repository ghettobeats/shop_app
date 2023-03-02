import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

import '../screens/product_detail_screen.dart';
import '../screens/product_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
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
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen()
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
      ),
      body: const Center(
        child: Text(
          'You have pushed the button this many times:',
        ),
      ),
    );
  }
}
