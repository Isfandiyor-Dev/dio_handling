import 'package:dio_handling/models/category.dart';
import 'package:flutter/foundation.dart';

class Product {
  int id;
  String title;
  double price;
  String description;
  CategoryModel category;
  List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  // JSON'dan Product ob'ektiga o'tkazish metodi
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: CategoryModel.fromJson(json['category']),
      images: List<String>.from(json['images']),
    );
  }

  // Product ob'ektidan JSON'ga o'tkazish metodi
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'images': images,
    };
  }
}

// void main() {
//   // Misol uchun, JSON string
//   String jsonString = '''
//   {
//     "id": 1,
//     "title": "Product Title",
//     "price": 29.99,
//     "description": "This is a product description.",
//     "category": 2,
//     "images": [
//       "http://example.com/image1.jpg",
//       "http://example.com/image2.jpg"
//     ]
//   }
//   ''';

//   // JSON stringni Map'ga o'tkazish
//   Map<String, dynamic> productMap = jsonDecode(jsonString);

//   // Map'dan Product ob'ektini yaratish
//   Product product = Product.fromJson(productMap);

//   // Product ob'ektini JSON'ga o'tkazish
//   String productToJson = jsonEncode(product.toJson());

//   print('Original JSON: $jsonString');
//   print('Product Object: $product');
//   print('Product to JSON: $productToJson');
// }
