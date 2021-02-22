import 'package:flutter/material.dart';

import '../../../core/entities/product.dart';
import '../../widgets/gradient_colored_long_action_button.dart';
import 'homepage.dart';


class ProductCardHomePage extends StatelessWidget {
  final double height;
  final double width;
  final Product product;
  final String buttonActionWord;
  final bool includeActionButton;

  const ProductCardHomePage({
    @required this.product, 
    @required this.width,
    @required this.height, 
    this.includeActionButton = true,
    this.buttonActionWord = "SHOP"
  });

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              product.imageUrl,
              fit: BoxFit.fitHeight,
            ),
            RichText(
                text: TextSpan(
                    text: "${product.name}\n\n",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 11, fontWeight: FontWeight.w700),
                    children: [
                  TextSpan(
                      text: "${product.category.name}\n\n\n",
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontSize: 9,
                          )),
                  TextSpan(
                    text: " \$${product.price.toStringAsFixed(0)}",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontWeight: FontWeight.w800),
                  )
                ])),
            Expanded(
              child: SizedBox(),
            ),
            includeActionButton 

              ? GradientColoredLongActionButton(
                text: buttonActionWord,
                onPressed: () {},
                width: width * 0.21,
                height: height * 0.034)

              : SizedBox()
          ],
        ));
  }
}
