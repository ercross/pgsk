import 'package:flutter/material.dart';
import 'package:pgsk/views/screens/home_screen/homepage.dart';
import '../../../core/entities/product.dart';

class ProductCardCategoryPage extends StatelessWidget {
  final BoxConstraints size;
  final Product product;

  const ProductCardCategoryPage({
    @required this.size,
    @required this.product
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //the 0.2 accounts for the horizontal padding and margin
      width: (size.maxWidth * HomePage.screenWidthMultiplier) / 2.2,
      //height: size.maxHeight * 0.27,
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(product.imageUrl,),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                text: product.name + "\n",
                style: Theme.of(context).textTheme.caption
                          .copyWith(fontSize: 11, fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: product.category.name,
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 9,
                            ),
                  )
                ]
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("\$" + product.price.toStringAsFixed(0), style: Theme.of(context)
                          .textTheme.caption.copyWith(fontWeight: FontWeight.w800),
                    ),
          ),
        ],
      )
    );
  }
}