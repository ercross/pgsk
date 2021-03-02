import 'package:pgsk/core/entities/product_category.dart';

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


  // ************************************ ORDER FUNCTIONS ************************************/
  Future<List<Order>> fetchAllOrders();


  // ************************************ REVIEWS FUNCTIONS *********************************/
  Future<List<ProductReview>> fetchReviewsByProductName();

  Future<List<ProductReview>> fetchReviewsWrittenByMe();
}

  // static const String prefix = "assets/images/";
  //   final List<Product> products = [
  //     Product(
  //         id: 1.toString(),
  //         name: "Avast Antivirus",
  //         price: 40,
  //         specification: "",
  //         description: "",
  //         categoryName:"Antivirus Protection",
  //         imageUrl: prefix + "product_1_avast.png"),

  //     Product(
  //         id: 2.toString(),
  //         name: "Quick Heal Antivirus",
  //         price: 50,
  //         specification: "",
  //         description: "",
  //         categoryName: "Internet Protection",
  //         imageUrl: prefix + "product_2_quickheal.png"),

  //     Product(
  //         id: 3.toString(),
  //         name: "Kaspersky Antivirus",
  //         price: 60,
  //         specification: "",
  //         description: "",
  //         categoryName: "Antivirus Protection",
  //         imageUrl: prefix + "product_3_kaspersky.png"),
  //   ];