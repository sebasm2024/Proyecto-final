import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/product_detail_widget.dart';

class ProductDetailView extends ConsumerWidget {
  final String? productId;
  const ProductDetailView({super.key, this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Asegurarse con un print
    final productByidRef = ref.watch(productByIdProvider(productId ?? ''));
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Detail View",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const DrawerWidget(),
      body: productByidRef.when(
        data: (item) => Padding(
          padding: const EdgeInsets.all(20),
          child: ProductDetailWidget(
            id: item.id,
            url: item.urlImage,
            name: item.name,
            price: item.price,
            stock: item.stock,
            description: item.description,
          ),
        ),
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
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
