import '../../entities/product_category.dart';

import '../../entities/order.dart';
import '../../entities/product.dart';
import '../../entities/product_review.dart';

///EntitiesRepository exposes read-only endpoint to some pgsk entities
///like products, category, orders, and reviews.
///Repository for entities specific to each user, wishlist and cart,
///is contained within user_account_services_repository.dart
abstract class EntitiesRepository {
  // ************************************** PRODUCT FUNCTIONS **********************************/
  Future<List<Product>> fetchAllProducts();

  ///refreshProductInfo refetches @param product from the server to avoid any discrepancies in price
  Future<Product> refreshProductInfo(Product product);

  Future<List<Product>> fetchProductsByCategory(String categoryName);

  // ************************************* PRODUCTCATEGORY FUNTCIONS ***************************/
  Future<List<String>> fetchAllCategoriesName();

  Future<List<ProductCategory>> fetchAllProductCategories();

  // ************************************* PRODUCTCATEGORY FUNTCIONS ***************************/
  Future<List<ProductCategory>> fetchAllProductBrands();
  Future<List<Product>> fetchBrandProducts(String brandName);

  // ************************************ ORDER FUNCTIONS ************************************/
  Future<List<Order>> fetchAllOrders();

  // ************************************ REVIEWS FUNCTIONS *********************************/
  Future<List<ProductReview>> fetchReviewsByProductName();

  Future<List<ProductReview>> fetchReviewsWrittenByMe();
}
