import 'package:dio_handling/controllers/dio_products_controller.dart';
import 'package:dio_handling/views/widgets/edit_product_dialog.dart';
import 'package:flutter/material.dart';
import 'package:dio_handling/models/product.dart';
import 'package:provider/provider.dart';

class ItemProduct extends StatefulWidget {
  final Product product;
  const ItemProduct({super.key, required this.product});

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  void showEditProductDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditProductDialog(
          product: product,
        );
      },
    ).then((result) {
      if (result != null) {
        // ignore: avoid_print
        print(result);
        // ignore: use_build_context_synchronously
        Provider.of<DioProductsController>(context, listen: false)
            .updateProduct(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        widget.product.images.isNotEmpty ? widget.product.images[0] : '';

    // Check if the URL is valid
    bool isValidUrl = Uri.tryParse(imageUrl)?.hasAbsolutePath ?? false;

    if (!isValidUrl) {
      // Log the invalid URL for debugging
      print('Invalid URL: $imageUrl');
      // Use a placeholder image or handle the error as needed
      imageUrl = 'https://via.placeholder.com/150';
    }

    return Container(
      height: 170,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 30),
          SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  widget.product.description,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.product.price}\$",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showEditProductDialog(context, widget.product);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Provider.of<DioProductsController>(
                              context,
                              listen: false,
                            ).deleteProductById(widget.product.id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
