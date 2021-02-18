import 'package:flutter/cupertino.dart';

import '../../core/entities/product.dart';

///Cart doesn't extends Equatable as Cart is implemented as a singleton
class Cart with ChangeNotifier{
  int numberOfItems;
  final List<Product> products = List<Product>();
  double total;

  //singleton implementation
  Cart._singleton();
  static final Cart singleton = Cart._singleton();
  factory Cart() => singleton;

  void addProduct(Product product) {
    products.add(product);
    numberOfItems += 1;
    total += product.price;
    notifyListeners();
  }

  void removeProduct(Product product) {
    if (products.contains(product)) {
      products.remove(product);
      numberOfItems -= 1;
      total -= product.price;
      notifyListeners();
    }
  }

  @override
    String toString() => "Cart info\n number of items: $numberOfItems \ntotal: $total \n products: $products";
}