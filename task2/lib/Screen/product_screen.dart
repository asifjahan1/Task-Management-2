// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:task2/Provider/product_provider.dart';
// import 'package:task2/Model/product.dart';

// class ProductScreen extends StatelessWidget {
//   const ProductScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size; // Get screen size

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Products',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFFF36B11),
//       ),
//       body: Consumer<ProductProvider>(
//         builder: (context, productProvider, _) {
//           if (productProvider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return RefreshIndicator(
//             onRefresh: () async {
//               await productProvider.loadProducts();
//             },
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return GridView.builder(
//                   padding: const EdgeInsets.all(8.0),
//                   itemCount: productProvider.products.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: size.width < 600 ? 2 : 4,
//                     crossAxisSpacing: 8.0,
//                     mainAxisSpacing: 8.0,
//                     childAspectRatio: size.width < 600 ? 0.7 : 0.8,
//                   ),
//                   itemBuilder: (context, index) {
//                     Product product = productProvider.products[index];
//                     return Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xfffcef3c4),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Card(
//                         color: Colors.transparent, // Make card transparent
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 4,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               flex: 3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.network(
//                                     product.image,
//                                     fit: BoxFit.cover,
//                                     width: double.infinity,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 2,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       product.title,
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: size.width < 600 ? 14 : 16,
//                                         color: Colors
//                                             .white, // Text color white for visibility
//                                       ),
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Text(
//                                       '\$${product.price}',
//                                       style: TextStyle(
//                                         fontSize: size.width < 600 ? 12 : 14,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// iimport 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/Provider/product_provider.dart';
import 'package:task2/Model/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF36B11),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          if (productProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              await productProvider.loadProducts();
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: productProvider.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                Product product = productProvider.products[index];
                return Card(
                  // color: const Color(0xFFCEF3C4),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: product.image,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              product.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${product.price}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
