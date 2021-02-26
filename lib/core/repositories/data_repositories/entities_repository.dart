import 'package:pgsk/core/entities/product.dart';

abstract class EntitiesRepository {
  Future<List<Product>> fetchAllProducts();

  Future<List<Product>> fetchProductByCategory(String categoryName);

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