import 'package:flutter/material.dart';

import '../models/product.dart';

class ProducItem extends StatelessWidget {
  ProducItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) =>
      GridTile(child: Image.network(imageUrl));
}
