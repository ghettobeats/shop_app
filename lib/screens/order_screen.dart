import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widget/appDrawer.dart';
import 'package:shop_app/widget/order_item.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static const routeName = '/orders';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future _orderFuture;
  Future _obtainOrdersFuture() =>
      Provider.of<OrderServices>(context, listen: false).fetchAndSetOrder();
  @override
  void initState() {
    _orderFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<OrderServices>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your orders')),
      body: FutureBuilder(
          future: _orderFuture,
          builder: (ctx, dataSnap) {
            if (dataSnap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (dataSnap.error != null) {
              return Center(
                child: Text("Error"),
              );
            } else {
              return Consumer<OrderServices>(
                builder: (ctx, ordetData, child) => ListView.builder(
                  itemCount: ordetData.orders.length,
                  itemBuilder: (context, index) =>
                      OrderItem(ordetData.orders[index]),
                ),
              );
            }
          }),
      drawer: AppDrawer(),
    );
  }
}
