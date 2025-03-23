import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task2/Model/product.dart';

class DatabaseHelper {
  static const _databaseName = "products.db";
  static const _databaseVersion = 1;

  static const table = 'products';

  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnPrice = 'price';
  static const columnImage = 'image';

  // Singleton pattern for DatabaseHelper
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Get the path to the database
    String path = join(await getDatabasesPath(), _databaseName);

    // Open the database
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) async {
      // Create the table
      await db.execute('''
            CREATE TABLE $table (
              $columnId INTEGER PRIMARY KEY,
              $columnTitle TEXT NOT NULL,
              $columnDescription TEXT NOT NULL,
              $columnPrice REAL NOT NULL,
              $columnImage TEXT NOT NULL
            )
          ''');
    });
  }

  Future<int> insertProduct(Product product) async {
    Database db = await database;
    return await db.insert(table, product.toMap());
  }

  Future<List<Product>> fetchAllProducts() async {
    Database db = await database;
    var result = await db.query(table);
    return result.isNotEmpty
        ? result.map((e) => Product.fromMap(e)).toList()
        : [];
  }

  Future<int> updateProduct(Product product) async {
    Database db = await database;
    return await db.update(table, product.toMap(),
        where: '$columnId = ?', whereArgs: [product.id]);
  }

  Future<int> deleteProduct(int id) async {
    Database db = await database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
