import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../checkout_screen/checkout_screen.dart';
import '../product_info_screen/product_info_screen.dart';
import '../../../controllers/providers/wishlist.dart';
import '../home_screen/product_card_homepage.dart';
import 'package:provider/provider.dart';

import '../home_screen/homepage.dart';

class WishlistPage extends StatelessWidget {
  final BoxConstraints size;

  WishlistPage(this.size);

  static BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    final Wishlist wishlist = Provider.of<Wishlist>(context);
    return Center(
        child: SizedBox(
      width: size.maxWidth * HomePage.screenWidthMultiplier,
      child: ListView(
        children: wishlist.products
            .map<ProductCardHomePage>((product) => ProductCardHomePage(
                  onActionButtonPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => ProductInfoPage(product))),
                  buttonActionWord: "BUY",
                  product: product,
                  height: size.maxHeight,
                  width: size.maxWidth,
                ))
            .toList(),
      ),
    ));
  }
}
