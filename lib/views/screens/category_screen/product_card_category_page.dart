import 'package:flutter/material.dart';
import '../../widgets/favorite_button.dart';
import 'package:provider/provider.dart';

import '../../../controllers/providers/cart.dart';
import '../../../core/entities/product.dart';
import '../../../main.dart';
import '../product_info_screen/product_info_screen.dart';

class ProductCardCategoryPage extends StatelessWidget {
  ///height is the height of the card
  final double height;

  ///width is the width of the card
  final double width;
  final Product product;

  const ProductCardCategoryPage(
      {@required this.height, @required this.width, @required this.product});

  static BuildContext ctx;

  Widget _buildShopButton() {
    return Container(
        width: width * 0.2,
        height: height * 0.15,
        margin: EdgeInsets.only(bottom: 10, right: 5),
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(ctx).primaryColorLight,
                  Theme.of(ctx).primaryColor
                ])),
        child: GestureDetector(
          child: Center(
            child: Text("BUY",
                textAlign: TextAlign.center,
                style: Theme.of(ctx).textTheme.bodyText1),
          ),
          onTap: () {},
        ));
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;

    final Widget titleAndPrice = RichText(
      text: TextSpan(
          text: product.name + "\n",
          style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: 14,
              ),
          children: [
            TextSpan(
                text: product.categoryName,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.grey))
          ]),
    );

    ///_actionButtons contains the add-to-cart and buy buttons
    final Widget _actionButtons = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: FavoriteButton(product),
        ),
        IconButton(
            onPressed: () =>
                Provider.of<Cart>(context, listen: false).addProduct(product),
            icon: Icon(Icons.add_shopping_cart_rounded,
                color: Theme.of(context).accentColor)),
        Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.only(bottom: 2, right: 8.0),
          child: _buildShopButton(),
        )
      ],
    );

    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ProductInfoPage(product))),
      child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(top: 10, left: 3, right: 5, bottom: 3),
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow()],
              color: Colors.white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(product.imageUrl,
                  width: width * 0.3, height: height * 0.8),
              Expanded(
                child: SizedBox(
                  height: height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: titleAndPrice,
                      ),
                      Text(
                          "\n${PGSK.currency}${product.price.toStringAsFixed(0)}",
                          style: PGSK.homepageTexts),
                      Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: _actionButtons),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
