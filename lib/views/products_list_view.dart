import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/types/product.dart';

import '../providers/product_provider.dart';
import '../widgets/card_item_product.dart';
import '../widgets/drawer_widget.dart';

class ProductsListView extends ConsumerWidget {
  const ProductsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productProv = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Products View",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const DrawerWidget(),
      body: productProv.when(
        data: (List<Product> products) {
          if (products.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'No products available.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: products.map((product) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CardItemProduct(
                    id: product.id,
                    url: product.urlImage,
                    name: product.name,
                    price: product.price,
                    stock: product.stock,
                    description: product.description,
                  ),
                );
              }).toList(),
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${error.toString()}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Stack Trace: ${stackTrace.toString()}',
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        loading: () => Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
