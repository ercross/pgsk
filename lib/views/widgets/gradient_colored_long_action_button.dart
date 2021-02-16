import 'package:flutter/material.dart';

class GradientColoredLongActionButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double width;
  final double height;

  const GradientColoredLongActionButton({
    this.height,
    this.width = double.infinity,
    @required this.text, 
    @required this.onPressed
  });

  @override
  Widget build(BuildContext context) => 
    Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: 20, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColorLight,
            Theme.of(context).primaryColor
          ]
        )
      ),
      child: Center(
        child: FlatButton(
          child: Text(text, style: Theme.of(context).textTheme.bodyText1),
          onPressed: onPressed,
      ))
    );
}