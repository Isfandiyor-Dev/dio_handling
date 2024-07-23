import 'package:dio/dio.dart';
import 'package:dio_handling/models/product.dart';
import 'package:dio_handling/services/dio_client.dart';

class DioProductsService {
  final _dioClient = DioClient();

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dioClient.get(url: "");

      List<Product> products = [];

      for (var productData in response.data) {
        products.add(Product.fromJson(productData));
      }

      return products;
    } on DioException catch (e) {
      print(e.response?.data);
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Product> addProduct(Map<String,dynamic> product) async {
    try {
      final response = await _dioClient.post(
        url: "",
        data: product,
      );

      return Product.fromJson(response.data);
    } on DioException catch (e) {
      print(e.response?.data);
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Product> updateProduct(Product product) async {
    try {
      final response = await _dioClient.update(
        url: "/${product.id}",
        data: product.toJson(),
      );

      return Product.fromJson(response.data);
    } on DioException catch (e) {
      print(e.response?.data);
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      await _dioClient.delete(url: "/$productId");
      print('Product deleted!');
    } on DioException catch (e) {
      print(e.response?.data);
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
