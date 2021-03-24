import 'package:flutter/cupertino.dart';
import '../../core/repositories/services_repository/e_commerce_services_repository.dart';

import '../../core/entities/product.dart';

class Wishlist with ChangeNotifier {
  final ECommerceServicesRepository repository;

  Wishlist(this.repository);

  Set<Product> _products = Set<Product>();
  Set<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    if (_products.contains(product)) {
      _products.remove(product);
      notifyListeners();
    }
  }

  void fetchMyWishlist() async {
    if (_products.isEmpty) {
      _products = await repository.fetchWishlistItems();
      if (_products != null) _products = Set<Product>();
      notifyListeners();
    }
  }
}
