import 'package:flutter/material.dart';
import 'package:pgsk/views/screens/explore_screen/cart_screen/cart_screen.dart';
import '../../controllers/providers/cart.dart';
import 'package:provider/provider.dart';

class CustomCart extends StatelessWidget {
  CustomCart();

  @override
  Widget build(BuildContext context) {
    final Cart cartProvider = Provider.of<Cart>(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => CartPage())
      ),
      child: LayoutBuilder(
        builder: (_, constraint) => Stack(

          children: [
            Positioned(
              top: 20,
              right: 14,
              child: Icon(Icons.shopping_cart_rounded, color: Colors.black,)),
            Positioned(
              right: 3,
              top: 0,
              child: Container(
                width: 20,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).accentColor
                ),
                child: Text(cartProvider.totalNumberOfProducts.toString(), textAlign: TextAlign.center)
              ),
            )
          ],
        ),
      ),
    );
  }
}