import 'package:sqflite/sqflite.dart';
import 'package:task2/Model/product.dart';

class DBHelper {
  static Future<Database> initDatabase() async {
    // Open the database (or create it if it doesn't exist)
    return openDatabase(
      'products.db',
      onCreate: (db, version) {
        // Create the products table if it's not already created
        return db.execute(
          'CREATE TABLE products(id INTEGER PRIMARY KEY, title TEXT, description TEXT, price REAL, image TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> saveProduct(Product product) async {
    final db = await initDatabase();
    await db.insert('products', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Product>> getAllProducts() async {
    final db = await initDatabase();
    final List<Map<String, dynamic>> maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        price: maps[i]['price'],
        image: maps[i]['image'],
      );
    });
  }
}
