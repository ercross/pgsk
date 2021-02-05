import 'package:flutter/material.dart';

import 'bottom_nav_bar.dart';
import 'custom_app_bar.dart';

class HomePage extends StatelessWidget {
  HomePage();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double statusBarHeight = mediaQuery.padding.top;
    final double appBarHeight = AppBar().preferredSize.height;
    final double navBarHeight = mediaQuery.padding.bottom;
    final double displayAreaHeight = mediaQuery.size.height - statusBarHeight - navBarHeight - appBarHeight;
    final double appBarPreferredSize = displayAreaHeight * 0.38;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      appBar: AppBar(
        
                title: Text("PGSK",),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 10),
                    child: Icon(Icons.shopping_cart),
                  )
                ],
              ),
      //endDrawer: Drawer(),
      body: Container(
          color: Colors.grey.withOpacity(0.2),
          height: displayAreaHeight,
          child: CustomAppBar(appBarPreferredSize)),
    );
  }
}
