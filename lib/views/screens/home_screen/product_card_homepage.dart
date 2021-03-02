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

  const ProductCardHomePage(
      {@required this.product,
      @required this.width,
      @required this.height,
      this.includeActionButton = true,
      this.buttonActionWord = "SHOP"});

  Widget _buildInfoText(BuildContext context) {
    return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text("${product.name}",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
              ),
              Text("${product.categoryName}\n",
                  style: Theme.of(context).textTheme.subtitle2.copyWith( fontWeight: FontWeight.w600,
                        fontSize: 12,
                      )),
              Expanded(
                child: Text(
                  " \$${product.price.toStringAsFixed(0)}",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              )
            ]);
  }

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
          children: [
            Image.asset(
              product.imageUrl,
              fit: BoxFit.fitHeight,
            ),
            _buildInfoText(context),
            Expanded(
              child: SizedBox(),
            ),
            includeActionButton
                ? GradientColoredLongActionButton(
                    text: buttonActionWord,
                    onPressed: () {},
                    width: width * 0.25,
                    height: height * 0.034)
                : SizedBox()
          ],
        ));
  }
}
