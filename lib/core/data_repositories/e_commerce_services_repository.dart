import '../../controllers/providers/cart.dart';
import '../entities/order.dart';
import '../entities/product.dart';

///TODO: To ensure users have access to the same services both on mobile and web platform,
///concrete implementations should ensure changes effected through these methods are persisted both locally and remotely
abstract class ECommerceServicesRepository {
  
  ///returns true if written is successfully persisted on db server
  ///concrete implementation must ascertain that user isCustomer
  ///check Product documentation for info on the field, isCustomer
  Future<bool> writeReviewFor({Product product}); 

  Future<bool> updateCart(Cart cart);

  Future<bool> checkout(Order order);

  Future<bool> updateWishlist(List<Product> wishlist);

  Future<bool> createNewOrder(Order newOrder);

  Future<bool> markOrderSatisfied(String orderId);

  Future<bool> cancelOrder(String orderId);
}