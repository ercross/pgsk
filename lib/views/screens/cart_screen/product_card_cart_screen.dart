import 'package:flutter/material.dart';

import '../../../core/entities/product.dart';
import '../../../main.dart';

class ProductCardCartPage extends StatefulWidget {
  final int quantity;
  final BoxConstraints size;
  final Product product;

  ProductCardCartPage({
    @required this.quantity, 
    @required this.product, 
    @required this.size
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

    final Widget quantityBox = Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.grey, size: 14),
                    Expanded(child: Text(widget.quantity.toString(), 
                      textAlign: TextAlign.center, 
                      style: Theme.of(context).textTheme.button),),
                    Icon(Icons.remove, color: Colors.grey, size: 14)
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                )
              );

    final Widget removeItem = Container(
                padding: EdgeInsets.all(5),
                child: Center(child: Icon(Icons.close, color: Colors.white, size: 13)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                )
              );

    final Widget addAndRemoveBoxes = Column(
            children: [
              Expanded(child: quantityBox),
              removeItem,
            ],
          );

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      height: widget.size.maxHeight * 0.14,
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