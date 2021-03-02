import 'package:flutter/material.dart';
import '../../../controllers/providers/wishlist.dart';
import '../home_screen/product_card_homepage.dart';
import 'package:provider/provider.dart';

import '../home_screen/homepage.dart';

class WishlistPage extends StatelessWidget {
  final BoxConstraints size;

  WishlistPage(this.size);

  @override
  Widget build(BuildContext context) {
    final Wishlist wishlist = Provider.of<Wishlist>(context);
    return Center(
      child: SizedBox(
        width: size.maxWidth * HomePage.screenWidthMultiplier,
        child: ListView(
          children: wishlist.products.map<ProductCardHomePage>((product) => ProductCardHomePage(
            includeActionButton: false,
            product: product,
            height: size.maxHeight,
            width: size.maxWidth,)).toList(),
        ),
      )
    );
  }
}