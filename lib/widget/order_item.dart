import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as or;

class OrderItem extends StatelessWidget {
  final or.Order order;

  const OrderItem(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('${order.amount}'),
          subtitle: Text(
            DateFormat('dd MM yyy hh:mm').format(order.dateTime),
          ),
          trailing: IconButton(icon: Icon(Icons.expand_more), onPressed: () {}),
        )
      ]),
    );
  }
}
