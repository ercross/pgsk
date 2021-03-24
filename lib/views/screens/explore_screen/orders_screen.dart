import 'package:flutter/material.dart';

import '../../../core/entities/product.dart';
import '../../../main.dart';
import '../home_screen/homepage.dart';
import '../home_screen/product_card_homepage.dart';

class OrdersPage extends StatelessWidget {
  final BoxConstraints size;

  const OrdersPage(this.size);

  Widget _buildOrderProducts() {
    return Text(
      "No orders found",
      textAlign: TextAlign.center,
      style: PGSK.homepageTexts.copyWith(color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: size.maxHeight,
            width: size.maxWidth * HomePage.screenWidthMultiplier,
            child: _buildOrderProducts()));
  }
}
