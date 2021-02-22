import 'package:flutter/material.dart';

import '../../../../core/entities/product.dart';
import '../../../../main.dart';


class ProductCardCartPage extends StatefulWidget {
  final int quantity;

  ///containerHeight is the height of the container displaying a product
  final double containerheight;
  final Product product;

  ProductCardCartPage({
    @required this.quantity, 
    @required this.product, 
    @required this.containerheight
  });

  @override
  _ProductCardCartPageState createState() => _ProductCardCartPageState();
}

class _ProductCardCartPageState extends State<ProductCardCartPage> {

  @override
  Widget build(BuildContext context) {

    final Widget titleAndPrice = RichText(
            text: TextSpan(
              text: widget.product.name + "\n\n",
              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 11, color: Colors.black),
              children: [
                TextSpan(
                  text: "${PGSK.currency}${widget.product.price.toStringAsFixed(0)}",
                  style: Theme.of(context).textTheme.caption
                )
              ]
            ),           
          );

    final Widget removeItem = Container(
                padding: EdgeInsets.all(5),
                child: Center(child: Icon(Icons.close, color: Colors.white, size: 13)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                )
              );

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      height: widget.containerheight /* * 0.14 */,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow()],
        color: Colors.white
      ),
      child: Row(
        children: [
          Image.asset(widget.product.imageUrl),
          titleAndPrice,
          Flexible(child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(children: [Expanded(child: SizedBox()),removeItem]),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight, 
                  child: Text ("Quantity: ${widget.quantity}\n", 
                    style: Theme.of(context).textTheme.caption.copyWith(color : Theme.of(context).primaryColor),
                  ),),
              )
            ],
          )),
        ],
      )
    );
  }
}