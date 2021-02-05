import 'package:flutter/material.dart';

import 'product_tv.dart';

class CustomAppBar extends StatelessWidget{
  final double preferredHeight;

  const CustomAppBar(this.preferredHeight);

  @override
  Widget build(BuildContext context) {

    final Widget _bottom =  Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: ProductTV(),
      height: preferredHeight * 0.9, 
      width: double.infinity, //todo: remove this
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
    );

    final Widget _appBar = Container(
          child: Column(
            children: [
              AppBar(
                title: Text("PGSK"),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 10),
                    child: Icon(Icons.shopping_cart),
                  )
                ],
              ),
            ],
          ),
          height: preferredHeight,
          width: double.infinity,
          color: Theme.of(context).primaryColor.withOpacity(0.4));

    final Widget _top = Positioned(
          child: Card(
            elevation: 16,
            child: Container(
              height: preferredHeight * 0.4, 
              width: 300, //todo: remove this
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
            ),
          ),
          top: preferredHeight * 0.45,
          left: 25,
          right: 25
        );
        return _bottom;
    // return Stack(
    //   overflow: Overflow.visible,
    //   children: [
    //     _top,
    //     _appBar,
    //     _bottom,
    //   ]);
  }
}
