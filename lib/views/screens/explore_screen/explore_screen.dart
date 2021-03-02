import 'package:flutter/material.dart';
import 'package:pgsk/views/screens/explore_screen/cart_screen/cart_screen.dart';
import 'package:pgsk/views/screens/explore_screen/wishlist_screen.dart';

import '../../../main.dart';
import '../home_screen/custom_nav_bar.dart';
import 'orders_screen.dart';

class ExplorePage extends StatefulWidget {
  static const String routeName = "/explore-screen";
  static BuildContext ctx;

  const ExplorePage();

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(initialIndex: 1, vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ExplorePage.ctx = context;
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraint) {
          return Column(
          children: [
            SizedBox(
              width: constraint.maxWidth,
              height: constraint.maxHeight * 0.12,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TabBar(
                    labelStyle: PGSK.homepageTexts,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.all(8),
                    indicatorColor: Colors.grey,
                    indicatorWeight: 3,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.black,
                    controller: _tabController,
                    tabs: [
                      Tab(child: Text("Wishlist")),
                      Tab(child: Text("Cart")),
                      Tab(child: Text("Orders")),
                    ],
                  ),
                )),
            Expanded(
              child: TabBarView(
              
              controller: _tabController,
              children: [
                WishlistPage(constraint), 
                CartPage(constraint), 
                OrdersPage(constraint)],
            ),
            ),
            CustomBottomNavBar(constraint.maxWidth, context),
          ],
        );
        },
      ),
    );
  }
}

