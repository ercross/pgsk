import 'package:flutter/material.dart';
import 'package:pgsk/views/screens/home_screen/product_card_homepage.dart';

import '../../../core/entities/product.dart';
import '../home_screen/homepage.dart';

class WishlistPage extends StatelessWidget {
  final BoxConstraints size;

  WishlistPage(this.size);

  static const String prefix = "assets/images/";
    static final List<Product> _products = [
      Product(
        id: 1.toString(),
        name: "Avast Antivirus",
        price: 40,
        specification: "",
        description: "",
        categoryName: "Antivirus Protection",
        imageUrl: prefix + "product_1_avast.png"
      ),

      Product(
        id: 2.toString(),
        name: "Quick Heal Antivirus",
        price: 50,
        specification: "",
        description: "",
        categoryName: "Internet Protection",
        imageUrl: prefix + "product_2_quickheal.png"
      ),
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
  Widget build(BuildContext context) {
    
    return Center(
      child: SizedBox(
        width: size.maxWidth * HomePage.screenWidthMultiplier,
        child: ListView(
          children: _moreProducts.map<ProductCardHomePage>((product) => ProductCardHomePage(
            includeActionButton: false,
            product: product,
            height: size.maxHeight,
            width: size.maxWidth,)).toList(),
        ),
      )
    );
  }
}