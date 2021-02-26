import 'package:flutter/cupertino.dart';
import 'package:pgsk/views/screens/explore_screen/cart_screen/cart_screen.dart';

import '../../core/entities/product.dart';

///Cart doesn't extends Equatable as Cart is implemented as a singleton
class Cart with ChangeNotifier{
  int totalNumberOfProducts = 0;
  final List<ProductAndQuantity> productsAndQuantity = List<ProductAndQuantity>();
  double total = 0;

  ///uniqueProducts is like a Set, but customise for this particular use case
  ///i.e., to get a
  final Set<Product> _uniqueProducts = Set<Product>();

  //singleton implementation
  Cart._singleton();
  static final Cart singleton = Cart._singleton();
  factory Cart() => singleton;

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

  @override
    String toString() => "Cart info\n number of items: $totalNumberOfProducts \ntotal: $total \n products: $productsAndQuantity";
}