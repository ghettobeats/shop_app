import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as or;

class OrderItem extends StatefulWidget {
  final or.Order order;

  const OrderItem(this.order, {super.key});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('${widget.order.amount}'),
          subtitle: Text(
            DateFormat('dd MM yyy hh:mm').format(widget.order.dateTime),
          ),
          trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              }),
        ),
        if (_expanded)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: min(widget.order.products.length * 20.0 + 10, 100),
            child: ListView(
                children: widget.order.products
                    .map((e) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${e.quantity} X \$${e.price}',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.grey),
                              )
                            ]))
                    .toList()),
          )
      ]),
    );
  }
}
