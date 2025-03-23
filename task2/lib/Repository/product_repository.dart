// import 'package:sqflite/sqflite.dart';
// import 'package:task2/DataBase/db_helper.dart';
// import 'package:task2/Model/product.dart';

// class ProductRepository {
//   final Database database; // Database instance

//   // Constructor with named parameter for database
//   ProductRepository({required this.database});

//   // Save products to local database
//   Future<void> cacheProducts(List<Product> products) async {
//     for (var product in products) {
//       await DBHelper.saveProduct(product);
//     }
//   }

//   // Fetch products from local database
//   Future<List<Product>> getProducts() async {
//     return await DBHelper.getAllProducts();
//   }
// }
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task2/Model/product.dart';

class ProductRepository {
  final Database database;

  ProductRepository({required this.database});

  // Store products in local database
  Future<void> cacheProducts(List<Product> products) async {
    final batch = database.batch();
    for (var product in products) {
      String localImagePath =
          await _downloadAndSaveImage(product.image, product.id);

      batch.insert(
        'products',
        {
          'id': product.id,
          'title': product.title,
          'price': product.price,
          'image': localImagePath, // Store local image path
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  // Fetch products from local database
  Future<List<Product>> getProducts() async {
    final List<Map<String, dynamic>> maps = await database.query('products');
    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        image: maps[i]['image'],
        description: maps[i]['description'],
      );
    });
  }

  // Download image and save locally
  Future<String> _downloadAndSaveImage(String imageUrl, int productId) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/product_$productId.jpg';

      if (!File(filePath).existsSync()) {
        var response = await Dio().download(imageUrl, filePath);
        if (response.statusCode == 200) {
          return filePath;
        }
      }
      return filePath;
    } catch (e) {
      return imageUrl; // Return original URL if download fails
    }
  }
}
