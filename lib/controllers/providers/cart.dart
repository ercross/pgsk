import 'package:flutter/material.dart';
import 'package:pgsk/core/repositories/services_repository/e_commerce_services_repository.dart';

import '../../core/entities/product.dart';
import '../../views/screens/explore_screen/cart_screen/cart_screen.dart';

///Cart doesn't extends Equatable as Cart is implemented as a singleton
class Cart with ChangeNotifier{
  int totalNumberOfProducts = 0;
  final List<ProductAndQuantity> productsAndQuantity = List<ProductAndQuantity>();
  double total = 0;

  ///uniqueProducts is like a Set, but customise for this particular use case
  ///i.e., to get a
  final Set<Product> _uniqueProducts = Set<Product>();

  final ECommerceServicesRepository repository;

  Cart(this.repository);

  void addProduct(Product product) {
    if (_uniqueProducts.contains(product)) {
      productsAndQuantity.firstWhere(
        (productQuantity) => productQuantity.product.name.compareTo(product.name) == 0
      ).quantity++;
    }
    else{
      productsAndQuantity.add(ProductAndQuantity(product, 1));
      _uniqueProducts.add(product);
    } 

    totalNumberOfProducts++;
    total += product.price;
    notifyListeners();
  }

  void removeProduct(Product product) {
    if (_uniqueProducts.contains(product)) {

      ProductAndQuantity productAndQuantity = productsAndQuantity.firstWhere(
        (productQuantity) => productQuantity.product.name.compareTo(product.name) == 0
      );
      if (productAndQuantity.quantity == 1) {
        productsAndQuantity.remove(productAndQuantity);
        _uniqueProducts.remove(product);
      } 
      else productAndQuantity.quantity--;

      totalNumberOfProducts--;
      total -= product.price;
      notifyListeners();
    }
  }

  //TODO: fetches cart products at first start
  void fetchMyCart() {

  }

  //TODO: implement to resync the price of these products with the PGSK server
  void refreshProductsInfo (List<int> productIds){}

  @override
    String toString() => "Cart info\n number of items: $totalNumberOfProducts \ntotal: $total \n products: $productsAndQuantity";
}