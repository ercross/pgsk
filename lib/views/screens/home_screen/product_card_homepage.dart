import 'package:flutter/material.dart';

import '../../../core/entities/product.dart';
import 'homepage.dart';

class ProductCardHomePage extends StatelessWidget {
  final double height;
  final double width;
  final Product product;
  final String buttonActionWord;
  final bool includeActionButton;
  final Function onActionButtonPressed;

  const ProductCardHomePage(
      {@required this.onActionButtonPressed,
      @required this.product,
      @required this.width,
      @required this.height,
      this.includeActionButton = true,
      this.buttonActionWord = "SHOP"});

  static BuildContext ctx;

  Widget _buildInfoText(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text("${product.name}",
                        style: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(),
              )
            ],
          ),
          Text("${product.categoryName}\n",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  )),
          Expanded(
            child: SizedBox(
              //width: width * 0.6,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Text(
                      " \$${product.price.toStringAsFixed(0)}",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    includeActionButton ? _buildShopButton() : SizedBox()
                  ]),
            ),
          )
        ]);
  }

  Widget _buildShopButton() {
    return Container(
        width: width * 0.2,
        height: height * 0.15,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(bottom: 10, right: 5),
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
            child: Text(buttonActionWord,
                textAlign: TextAlign.center,
                style: Theme.of(ctx).textTheme.bodyText1),
          ),
          onTap: () {},
        ));
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Container(
        padding: EdgeInsets.only(bottom: 5),
        margin: EdgeInsets.symmetric(vertical: 5),
        height: height * 0.13,
        width: width * HomePage.screenWidthMultiplier,
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Colors.grey,
          )),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              product.imageUrl,
              fit: BoxFit.fitHeight,
            ),
            Expanded(child: _buildInfoText(context)),
          ],
        ));
  }
}
