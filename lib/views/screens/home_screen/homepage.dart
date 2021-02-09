import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage();

  static const String routeName = "homepage";

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double statusBarHeight = mediaQuery.padding.top;
    final double appBarHeight = AppBar().preferredSize.height;
    final double navBarHeight = mediaQuery.padding.bottom;
    final double displayAreaHeight = mediaQuery.size.height - statusBarHeight - navBarHeight - appBarHeight;
    final double appBarPreferredSize = displayAreaHeight * 0.38;
    return Scaffold( 
      body: Center(child: Text("status bar height: $statusBarHeight \napp bar height: $appBarHeight \n display area height: $displayAreaHeight \n width: ${mediaQuery.size.width}", style: Theme.of(context).textTheme.bodyText2))
    );
    
  }
}
