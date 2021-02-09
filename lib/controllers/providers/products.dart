import 'package:flutter/material.dart';
import 'package:pgsk/core/data_repositories/product_repository.dart';

import '../../core/entities/product_category.dart';
import '../../core/entities/product.dart';

class Products with ChangeNotifier {
  List<Product> allProducts = List<Product>();
  List<Product> productByCategory = List<Product>();

  final ProductRepository productRepository;

  Products({@required this.productRepository});

  ///fetchAllProducts fetches all product from GPSK server
  void fetchAllProducts() async {
    final List<Product> products = await productRepository.fetchAllProducts();
    allProducts = products;
    notifyListeners();
  }

  ///fetchProductsBy fetches products by category by first checking if this.allProducts.isNotEmpty
  ///if this.allProducts.isEmpty, it queries PGSK server for the requested category products
  void fetchProductsBy({@required ProductCategory productCategory}) {

    //setting productByCategory to an empty list ensures that the current list 
    //(which may still contain the products from the category the user previously queried) is not built onto the widget tree.
    productByCategory = List<Product>();
    notifyListeners();

    if (allProducts.isNotEmpty) {
      allProducts.forEach((product) {
        if (product.productCategory.name.toLowerCase().compareTo(productCategory.name.toLowerCase()) == 0) {
          productByCategory.add(product);
        }
      });
    notifyListeners();
    }

    else {
      productRepository.fetchBy(productCategory).then(
        (value) {
          productByCategory = value;
          notifyListeners();
        } 
      );
    }
  }
}