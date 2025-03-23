import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task2/Provider/product_provider.dart';
import 'package:task2/Services/api_service.dart';
import 'package:task2/Repository/product_repository.dart';
import 'package:task2/Screen/product_screen.dart';
import 'package:task2/DataBase/db_helper.dart'; // Import DBHelper

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database
  Database database = await DBHelper.initDatabase();

  // Run the app
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final Database database; // Database instance

  // Constructor to receive the database
  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Providing the ApiService
        Provider<ApiService>(create: (_) => ApiService()),

        // Providing the ProductRepository with the database
        Provider<ProductRepository>(
          create: (_) => ProductRepository(database: database),
        ),

        // Providing the ProductProvider, which depends on both ApiService and ProductRepository
        ChangeNotifierProvider(
          create: (context) => ProductProvider(
            apiService: context.read<ApiService>(),
            productRepository: context.read<ProductRepository>(),
          )..loadProducts(), // Load products on startup
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task2 App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductScreen(), // Main screen where products are displayed
      ),
    );
  }
}
