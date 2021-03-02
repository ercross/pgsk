import 'package:pgsk/core/entities/product.dart';

import 'package:pgsk/core/entities/order.dart';

import '../../../core/repositories/services_repository/e_commerce_services_repository.dart';

class ECommerceServicesRepositoryImpl extends ECommerceServicesRepository {
  @override
  Future<bool> cancelOrder(String orderId) {
    // TODO: implement cancelOrder
    throw UnimplementedError();
  }

  @override
  Future<bool> checkout(Order order) {
    // TODO: implement checkout
    throw UnimplementedError();
  }

  @override
  Future<bool> createNewOrder(Order newOrder) {
    // TODO: implement createNewOrder
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> fetchCartItems() {
    //TODO: implement properly
    return Future.value(null);
  }

  @override
  Future<bool> markOrderSatisfied(String orderId) {
    // TODO: implement markOrderSatisfied
    throw UnimplementedError();
  }

  @override
  Future<bool> writeReviewFor({Product product}) {
    // TODO: implement writeReviewFor
    throw UnimplementedError();
  }

  @override
  Future<Set<Product>> fetchWishlistItems() {
    return Future.value(null);
  }

}