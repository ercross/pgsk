import 'package:flutter/material.dart';

import '../../../core/entities/product.dart';
import '../../../core/entities/product_category.dart';
import '../home_screen/homepage.dart';
import '../home_screen/product_card_homepage.dart';



class OrdersPage extends StatelessWidget {
  final BoxConstraints size;

  const OrdersPage(this.size);

    Widget _buildOrderProducts() {
    const String prefix = "assets/images/";
    final List<Product> products = [
      Product(
        id: 1.toString(),
        name: "Avast Antivirus",
        price: 40,
        specification: "",
        description: "",
        category: ProductCategory(id: 1.toString(), name: "Antivirus Protection"),
        imageUrl: prefix + "product_1_avast.png"
      ),
      Product(
        id: 2.toString(),
        name: "Quick Heal Antivirus",
        price: 50,
        specification: "",
        description: "",
        category: ProductCategory(id: 2.toString(), name: "Internet Protection"),
        imageUrl: prefix + "product_2_quickheal.png"
      ),
      Product(
        id: 3.toString(),
        name: "Kaspersky Antivirus",
        price: 60,
        specification: "",
        description: "",
        category: ProductCategory(id: 3.toString(), name: "Antivirus Protection"),
        imageUrl: prefix + "product_3_kaspersky.png"
      ),
    ];
    return ListView(
          children: products.map<ProductCardHomePage>((product) => ProductCardHomePage(
            includeActionButton: false,
            product: product,
            height: size.maxHeight,
            width: size.maxWidth,)).toList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size.maxHeight,
        width: size.maxWidth * HomePage.screenWidthMultiplier,
        child: _buildOrderProducts()
      )
    );
  }
}