import 'package:flutter/material.dart';
import 'package:pgsk/core/repositories/services_repository/e_commerce_services_repository.dart';

import '../../core/entities/product.dart';
import '../../views/screens/explore_screen/cart_screen/cart_screen.dart';

///Cart doesn't extends Equatable as Cart is implemented as a singleton
class Cart with ChangeNotifier{
  int _totalNumberOfProducts = 0;
  List<ProductAndQuantity> _productsAndQuantity = List<ProductAndQuantity>();
  double _total = 0;

  int get totalNumberOfProducts => _totalNumberOfProducts;
  List<ProductAndQuantity> get productsAndQuantity => _productsAndQuantity;
  double get total => _total;

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

    _totalNumberOfProducts++;
    _total += product.price;
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

      _totalNumberOfProducts--;
      _total -= product.price;
      notifyListeners();
    }
  }

  void fetchMyCart() async {
    if (_totalNumberOfProducts == 0 && _total == 0 && _productsAndQuantity.isEmpty) {
      List<Product> products = await repository.fetchCartItems();
      _totalNumberOfProducts = products.length;
      products.forEach((product) => _total += product.price);
      _productsAndQuantity = ProductAndQuantity.from(products: products);  
      notifyListeners();
    }
  }

  //TODO: implement to resync the price of these products with the PGSK server
  void refreshProductsInfo (List<int> productIds){}

  @override
    String toString() => "Cart info\n number of items: $totalNumberOfProducts \ntotal: $total \n products: $productsAndQuantity";
}