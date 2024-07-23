import 'package:dio_handling/controllers/dio_products_controller.dart';
import 'package:dio_handling/models/product.dart';
import 'package:dio_handling/views/widgets/add_product_dialog.dart';
import 'package:dio_handling/views/widgets/item_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DioProductsController>(context, listen: false).fetchProducts();
  }

  void showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddProductDialog();
      },
    ).then((result) {
      if (result != null) {
        // ignore: avoid_print
        print(result);
        // ignore: use_build_context_synchronously
        Provider.of<DioProductsController>(context, listen: false)
            .addNewProduct(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
        backgroundColor: Colors.grey[400],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[200],
        onPressed: () {
          showAddProductDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<DioProductsController>(
        builder: (context, controller, child) {
          if (controller.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          List<Product> products = controller.products.reversed.toList();
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (ctx, index) {
              Product product = products[index];
              return ItemProduct(product: product);
            },
          );
        },
      ),
    );
  }
}
