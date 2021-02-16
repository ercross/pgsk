import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget trailing;
  final double maxWidth;
  const CustomAppBar(this.maxWidth, 
    {this.title = "Discover", 
    this.trailing = Icon(Icons.shopping_cart)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(title, style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 19)),
          ),
          Expanded(child: SizedBox(),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: trailing,
          ),
        ],
      )
    );
  }
}