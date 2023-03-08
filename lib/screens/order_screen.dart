import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widget/appDrawer.dart';
import 'package:shop_app/widget/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderServices>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your orders')),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) => OrderItem(orderData.orders[index]),
      ),
      drawer: AppDrawer(),
    );
  }
}
