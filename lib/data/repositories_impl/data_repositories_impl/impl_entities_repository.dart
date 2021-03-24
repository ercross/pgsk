import 'dart:math';

import '../../../core/entities/order.dart';
import '../../../core/entities/product.dart';
import '../../../core/entities/product_category.dart';
import '../../../core/entities/product_review.dart';
import '../../../core/repositories/data_repositories/entities_repository.dart';

class EntitiesRepositoryImpl extends EntitiesRepository {
  static const String description =
      "Award winning protection for you PC or Mac against online Threats " +
          "F-Secure Antivirus provides advanced real-time detection and protection against viruses, spyware, " +
          "infected email attachments and all other types of malware. Automatic updates and real-time response " +
          "rates guarantee the fastest protection against all new threats, while Deep Guard Exploit " +
          "Protection elevates your protection to a new level. Easy to install and will not " +
          "slow down your computer. F-Secure Antivirus will protect you.";

  static const String specification =
      "Awarded Best Protection against viruses, spyware, and other malware " +
          "Always up-to-date with cloud-based technology. Stops intrusionns on your computer " +
          "or Mac. Instant response against all new threats. Easy to install and simple to use" +
          "Does not disturb you or slow down your computer or Mac";

  static const String _prefix = "assets/images/";
  static final List<Product> _products = [
    Product(
        name: "Avast Antivirus",
        price: 40,
        specification: specification,
        description: description,
        categoryName: "Antivirus Protection",
        imageUrl: _prefix + "product_1_avast.png"),
    Product(
      name: "Quick Heal Antivirus",
      price: 50,
      specification: specification,
      description: description,
      categoryName: "Internet Protection",
      imageUrl: _prefix + "product_2_quickheal.png",
    ),
    Product(
      name: "Kaspersky Antivirus",
      price: 60,
      specification: specification,
      description: description,
      categoryName: "Mobile Solutions",
      imageUrl: _prefix + "product_3_kaspersky.png",
    )
  ];

  final List<Product> _moreProducts = [
    ..._products,
    ..._products,
    ..._products,
    ..._products,
    ..._products,
    ..._products,
  ];

  @override
  Future<List<String>> fetchAllCategoriesName() {
    return Future.value([
      "family Solutions",
      "Business Solutions",
      "Mobile Security",
      "Internet Security",
      "Smart Devices",
      "All"
    ]);
  }

  @override
  Future<List<Order>> fetchAllOrders() {
    // TODO: implement fetchAllOrders
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> fetchBrandProducts(String brandName) async {
    final startIndex = Random(2).nextInt(18);
    final endIndex = Random(12).nextInt(18);
    return await Future.value(
        _moreProducts.getRange(startIndex, endIndex).toList());
  }

  @override
  Future<List<ProductCategory>> fetchAllProductBrands() async {
    return await Future.value([
      ProductCategory(
        name: "Kaspersky",
        products: _moreProducts,
        imageUrl: _prefix + "internet_security_circled.png",
      ),
      ProductCategory(
        name: "F-Secure",
        products: _moreProducts.sublist(1, 7),
        imageUrl: _prefix + "mobile_solution_circled.png",
      ),
      ProductCategory(
        name: "Comodo",
        products: _moreProducts.sublist(4, 9),
        imageUrl: _prefix + "internet_security_circled.png",
      ),
      ProductCategory(
        name: "Microsoft",
        products: _moreProducts.sublist(3, 11),
        imageUrl: _prefix + "mobile_solution_circled.png",
      ),
      ProductCategory(
        name: "Samsung",
        products: _moreProducts.sublist(2, 10),
        imageUrl: _prefix + "business_solution_circled.png",
      ),
      ProductCategory(
        name: "Norton",
        products: _moreProducts.sublist(0, 5),
        imageUrl: _prefix + "family_solution_circled.png",
      )
    ]);
  }

  @override
  Future<List<ProductCategory>> fetchAllProductCategories() async {
    return await Future.value([
      ProductCategory(
        id: 1,
        name: "Family Solutions",
        products: _moreProducts,
      ),
      ProductCategory(
        id: 2,
        name: "Business Solutions",
        products: _moreProducts.sublist(1, 7),
      ),
      ProductCategory(
        id: 3,
        name: "Mobile Security",
        products: _moreProducts.sublist(4, 9),
      ),
      ProductCategory(
        id: 4,
        name: "Internet Security",
        products: _moreProducts.sublist(3, 11),
      ),
      ProductCategory(
        id: 5,
        name: "Smart Devices",
        products: _moreProducts.sublist(2, 10),
      ),
      ProductCategory(
        id: 6,
        name: "All",
        products: _moreProducts,
      )
    ]);
  }

  @override
  Future<List<Product>> fetchAllProducts() async {
    return await Future.value(_moreProducts);
  }

  @override
  Future<List<Product>> fetchProductsByCategory(String categoryName) async {
    return await Future.value(_moreProducts);
  }

  @override
  Future<List<ProductReview>> fetchReviewsByProductName() async {
    // TODO: implement fetchReviewsByProductName
    throw UnimplementedError();
  }

  @override
  Future<List<ProductReview>> fetchReviewsWrittenByMe() async {
    // TODO: implement fetchReviewsWrittenByMe
    throw UnimplementedError();
  }

  @override
  Future<Product> refreshProductInfo(Product product) async {
    // TODO: implement refreshProductInfo
    throw UnimplementedError();
  }
}
