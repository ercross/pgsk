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
      body: Center(child: Text("Chill and take a Nap", style: Theme.of(context).textTheme.headline6))
    );
    
  }
}
