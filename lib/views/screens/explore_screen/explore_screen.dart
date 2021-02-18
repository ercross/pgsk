import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/providers/explore_page_info.dart';
import '../../../main.dart';
import '../cart_screen/cart_screen.dart';
import '../home_screen/custom_app_bar.dart';
import '../home_screen/custom_nav_bar.dart';

class ExplorePage extends StatelessWidget {
  static const String routeName = "/smart-devices";

  const ExplorePage();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExplorePageInfo> (
      create: (_) => ExplorePageInfo(),
      child: ExplorePageTabs()
    );
  }
}

class ExplorePageTabs extends StatelessWidget {

  static BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomAppBar(
                size: constraints, 
                title: null, 
                leading: Center(
                  child: Text("Cart", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700, fontSize: 19))
                ),
                trailing: Icon(Icons.edit_attributes_outlined, color: Colors.white)),
              SizedBox(height: 10,),
              Expanded(child: CartPage(constraints)),
              CustomBottomNavBar(constraints.maxWidth, context),
            ],
          );
        },
      )
    );
  }
}