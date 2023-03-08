import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';

import '../providers/Cart.dart' show Cartservices;
import '../widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cartservices>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(children: [
        Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  //Spacer(),
                  Chip(
                    label: Text(
                      '\$ ${cart.TotalAmount}',
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  TextButton(
                    child: Text("ORDER NOW"),
                    onPressed: () {
                      Provider.of<OrderServices>(context, listen: false)
                          .addOrder(
                              cart.items.values.toList(), cart.TotalAmount);
                      cart.clear();
                    },
                  )
                ]),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (ctx, i) => CartItems(
                cart.items.values.toList()[i].id,
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.keys.toList()[i]),
          ),
        )
      ]),
    );
  }
}
