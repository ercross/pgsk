import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget leading;
  final Widget trailing;
  final BoxConstraints size; //the size of the total page
  final String centerTitle;

  ///CustomAppBar is the app bar used in PGSK mobile app
  ///title is the title of the page
  ///To preserve the style of title app-wide, leading is provided as an alternative to title.
  ///Therefore, only one of title or leading must be provided
  ///CenterTitle is used to display the title if @leading is non-Text()
  const CustomAppBar(
      {this.leading,
      this.centerTitle,
      @required this.size,
      @required this.title,
      @required this.trailing})
      : assert(!(leading == null && title == null));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: size.maxHeight * 0.06),
        Container(
            width: size.maxWidth,
            height: size.maxHeight * 0.062,
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
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 19))
                      : leading,
                ),
                Expanded(
                  child: centerTitle != null
                      ? Text(centerTitle,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.w700,
                              fontSize: 19))
                      : SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(width: size.maxHeight * 0.1, child: trailing),
                ),
              ],
            )),
        SizedBox(height: size.maxHeight * 0.01)
      ],
    );
  }
}
