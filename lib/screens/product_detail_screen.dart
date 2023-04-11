import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  // final String title;

  // const ProductDetailsScreen({super.key, required this.title});
  static const routeName = '/product-details';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<ProductServices>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(loadedProduct.title),
            background: Hero(
              tag: loadedProduct.id!,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          const SizedBox(height: 10),
          Text(
            '\$${loadedProduct.price}',
            style: const TextStyle(color: Colors.grey, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              loadedProduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
          const SizedBox(height: 800),
        ]))
      ]),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Container(
      //         height: 300,
      //         width: double.infinity,
      //         child: Hero(
      //           tag: loadedProduct.id!,
      //           child: Image.network(
      //             loadedProduct.imageUrl,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       Text(
      //         '\$${loadedProduct.price}',
      //         style: TextStyle(color: Colors.grey, fontSize: 20),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       Container(
      //         padding: EdgeInsets.symmetric(horizontal: 10),
      //         width: double.infinity,
      //         child: Text(
      //           loadedProduct.description,
      //           textAlign: TextAlign.center,
      //           softWrap: true,
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
