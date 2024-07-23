import 'package:dio_handling/models/product.dart';
import 'package:dio_handling/services/dio_service.dart';
import 'package:flutter/material.dart';

class DioProductsController extends ChangeNotifier {
  final DioProductsService _dioUsersService = DioProductsService();

  List<Product> _products = [];
  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    try {
      _products = await _dioUsersService.getProducts();
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }

  Future<void> addNewProduct(Map<String,dynamic> product) async {
    try {
      Product newProduct = await _dioUsersService.addProduct(product);
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      print('Error adding product: $e');
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      Product updatedProduct = await _dioUsersService.updateProduct(product);
      int index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        _products[index] = updatedProduct;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating product: $e');
      rethrow;
    }
  }

  Future<void> deleteProductById(int productId) async {
    try {
      await _dioUsersService.deleteProduct(productId);
      _products.removeWhere((product) => product.id == productId);
      notifyListeners();
    } catch (e) {
      print('Error deleting product: $e');
      rethrow;
    }
  }
}
