import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/product_provider.dart';
import 'package:myapp/routes/app_routes.dart';
import 'package:myapp/types/product.dart';

import '../widgets/custom_input_text.dart';
import '../widgets/drawer_widget.dart';

class CreateUpdateView extends ConsumerWidget {
  final String? productId;
  const CreateUpdateView({super.key, this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController priceCtrl = TextEditingController();
    final TextEditingController stockCtrl = TextEditingController();
    final TextEditingController urlImageCtrl = TextEditingController();
    final TextEditingController descriptionCtrl = TextEditingController();

    final productIdProv = productId == null
        ? ref.watch(productEmptyProvider)
        : ref.watch(productByIdProvider(productId!));

    return Scaffold(
      appBar: AppBar(
        title: productId == null
            ? const Text("Create Product")
            : const Text("Update Product"),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productIdProv.when(
              data: (product) {
                if (productId != null) {
                  // Update inputs controllers
                  nameCtrl.text = product.name;
                  priceCtrl.text = product.price.toString();
                  stockCtrl.text = product.stock.toString();
                  urlImageCtrl.text = product.urlImage;
                  descriptionCtrl.text = product.description;
                }
                return Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Name product",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomInputText(
                        label: 'Name product',
                        hintText: product.name,
                        controller: nameCtrl,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Price",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomInputText(
                        label: 'Price',
                        hintText: product.price.toString(),
                        controller: priceCtrl,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Stock",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomInputText(
                        label: 'Stock',
                        hintText: product.stock.toString(),
                        controller: stockCtrl,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "URL Image",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomInputText(
                        label: 'URL Image',
                        hintText: product.urlImage,
                        controller: urlImageCtrl,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomInputText(
                        label: 'Description',
                        hintText: product.description,
                        controller: descriptionCtrl,
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            final Product productSubmit = Product(
                              id: productId ?? '',
                              name: nameCtrl.text,
                              price: double.parse(priceCtrl.text),
                              stock: double.parse(stockCtrl.text),
                              urlImage: urlImageCtrl.text,
                              description: descriptionCtrl.text,
                              v: 0,
                            );

                            if (productId == null) {
                              // Crear
                              ref.read(createProductProvider(productSubmit));
                            } else {
                              // Actualizar
                              ref.read(updateProductProvider(productSubmit));
                            }

                            context.push(AppRoutes.productsListView);
                            ref.invalidate(productsProvider);
                          },
                          child: Text(
                            productId == null ? 'Create' : 'Update',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              error: (err, trc) {
                return Column(
                  children: [Text('$err'), Text('$trc')],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
