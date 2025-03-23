import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task2/DataBase/db_helper.dart';
import 'package:task2/Model/product.dart';

class ApiService {
  static const String apiUrl = 'https://fakestoreapi.com/products';

  // Fetch products from the API
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Product> products = data.map((e) => Product.fromJson(e)).toList();

        // Save products to SQLite
        for (var product in products) {
          await DBHelper.saveProduct(product);
        }

        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  // Get products (from API if online, or from SQLite if offline)
  Future<List<Product>> getProducts() async {
    List<Product> products = await fetchProducts();

    // If no products from API (offline), get from local storage (SQLite)
    if (products.isEmpty) {
      products = await DBHelper.getAllProducts();
    }

    return products;
  }
}
