import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helpers/custom_route.dart';
import 'package:shop_app/screens/order_screen.dart';

import '../providers/auth.dart';
import '../screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
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
                // Navigator.of(context).pushReplacementNamed(OrderScreen.routeName),
                Navigator.of(context).pushReplacement(
              CustomRoute(
                builder: (ctx) => const OrderScreen(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductScreen.routeName),
          ),
          const Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }
}
