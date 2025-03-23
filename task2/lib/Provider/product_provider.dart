// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:task2/Services/api_service.dart';
// import 'package:task2/Model/product.dart';
// import 'package:task2/Repository/product_repository.dart';

// class ProductProvider extends ChangeNotifier {
//   final ApiService apiService;
//   final ProductRepository productRepository;
//   List<Product> _products = [];
//   bool _isLoading = false;

//   ProductProvider({
//     required this.apiService,
//     required this.productRepository,
//   });

//   List<Product> get products => _products;
//   bool get isLoading => _isLoading;

//   // Load products (from API if online, from DB if offline)
//   Future<void> loadProducts() async {
//     _isLoading = true;
//     notifyListeners();

//     // Check for internet connectivity
//     var connectivityResult = await Connectivity().checkConnectivity();

//     if (connectivityResult == ConnectivityResult.mobile ||
//         connectivityResult == ConnectivityResult.wifi) {
//       // Online - fetch data from the API and save it locally
//       try {
//         _products = await apiService.getProducts();
//         await productRepository.cacheProducts(_products); // Save products in DB
//       } catch (e) {
//         // If API call fails, try loading from local storage
//         _products = await productRepository.getProducts();
//       }
//     } else {
//       // Offline - fetch data from the local database
//       _products = await productRepository.getProducts();
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:task2/Services/api_service.dart';
import 'package:task2/Model/product.dart';
import 'package:task2/Repository/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService apiService;
  final ProductRepository productRepository;
  List<Product> _products = [];
  bool _isLoading = false;

  ProductProvider({
    required this.apiService,
    required this.productRepository,
  });

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        _products = await apiService.getProducts();
        await productRepository.cacheProducts(_products);
      } catch (e) {
        _products = await productRepository.getProducts();
      }
    } else {
      _products = await productRepository.getProducts();
    }

    _isLoading = false;
    notifyListeners();
  }
}
