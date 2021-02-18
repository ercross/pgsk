import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget leading;
  final Widget trailing;
  final BoxConstraints size;
  final String centerTitle;

  ///CustomAppBar is the app bar used in PGSK mobile app
  ///title is the title of the page
  ///To preserve the style of title app-wide, leading is provided as an alternative to title
  ///Only one of title or leading must be provided
  const CustomAppBar({
    this.leading, this.centerTitle, //these two fields are only currently used in explore_screen.dart
    @required this.size, 
    @required this.title, 
    @required this.trailing}) : assert(!(leading == null && title == null));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: size.maxHeight * 0.065),
        Container(
          width: size.maxWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: leading == null 
                  ? Text(title, 
                      style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700, fontSize: 19))
                  : leading,
              ),
              Expanded(child: SizedBox(),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: trailing,
              ),
            ],
          )
        ),
      ],
    );
  }
}