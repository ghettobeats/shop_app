import 'package:flutter/material.dart';
import 'package:shop_app/screens/order_screen.dart';

import '../screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text('Hello friend!'),
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('shop'),
          onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.credit_card),
          title: Text('orders'),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName),
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Manage Products'),
          onTap: () => Navigator.of(context)
              .pushReplacementNamed(UserProductScreen.routeName),
        ),
      ]),
    );
  }
}
