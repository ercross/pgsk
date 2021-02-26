import 'package:flutter/material.dart';
import 'package:pgsk/core/entities/product.dart';
import 'package:pgsk/core/entities/product_category.dart';
import 'package:pgsk/views/screens/home_screen/product_card_homepage.dart';

import '../home_screen/custom_nav_bar.dart';
import '../home_screen/homepage.dart';
import '../../../main.dart';
import '../home_screen/custom_app_bar.dart';

class UserAccountPage extends StatelessWidget {
  static const String routeName = "/user-account-page";
  UserAccountPage();

  static BuildContext ctx;

  Widget _buildProfilePicture() {
    final Widget editIcon = Positioned(
      bottom: 5,
      right: 5,
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(ctx).primaryColorLight,
                    Theme.of(ctx).primaryColor,
                  ])),
          child: Icon(Icons.edit_location_outlined,
              color: Colors.white, size: 21)),
    );

    return Stack(
      overflow: Overflow.visible,
      children: [Image.asset("assets/images/profile_pics.png"), editIcon],
    );
  }

  Widget _buildAData({@required String data, @required dataName}) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "$dataName:    ",
            style: Theme.of(ctx).textTheme.subtitle2.copyWith(fontSize: 11),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(top: 8, bottom: 3, left: 0, right: 15),
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                child: Text("$data       ", style: PGSK.homepageTexts)),
          ),
        ],
      );

  Widget _buildUserInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Details",
          style: PGSK.homepageTexts
              .copyWith(color: Theme.of(ctx).accentColor.withOpacity(0.6)),
        ),
        _buildAData(data: "Donald Trump", dataName: "Name"),
        _buildAData(data: "Donaldtrump@ex.postus", dataName: "Email"),
        _buildAData(data: "Transgender", dataName: "Gender"),
        _buildAData(data: "+1 342 3731289", dataName: "Phone Number"),
        Container(
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.only(top: 8, left: 0, right: 8, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address",
                  style: PGSK.homepageTexts,
                ),
                Text(
                    "334 Denzel Washington Drive,\nWashington DC,\nUnited States of America.",
                    style: Theme.of(ctx)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: 11)),
              ],
            )),
      ],
    );
  }

  static const String prefix = "assets/images/";
  final List<Product> staticProducts = [
    Product(
        id: 1.toString(),
        name: "Avast Antivirus",
        price: 40,
        specification: "",
        description: "",
        categoryName: "Antivirus Protection",
        imageUrl: prefix + "product_1_avast.png"),

    Product(
        id: 2.toString(),
        name: "Quick Heal Antivirus",
        price: 50,
        specification: "",
        description: "",
        categoryName: "Internet Protection",
        imageUrl: prefix + "product_2_quickheal.png"),

    Product(
        id: 3.toString(),
        name: "Kaspersky Antivirus",
        price: 60,
        specification: "",
        description: "",
        categoryName: "Antivirus Protection",
        imageUrl: prefix + "product_3_kaspersky.png"),
  ];

  Widget _buildWishlist(
      {@required List<Product> products, @required BoxConstraints size}) {
    final Widget title = Center(
        child: Text("Wishlist",
            style: PGSK.homepageTexts
                .copyWith(color: Theme.of(ctx).accentColor.withOpacity(0.8))));

    return ListView(
      children: [
        title,
        ...products
            .map<ProductCardHomePage>((product) => ProductCardHomePage(
                  buttonActionWord: "BUY",
                  product: product,
                  width: size.maxWidth,
                  height: size.maxHeight
                ))
            .toList()
      ],
    );
  }

  Widget _buildMiddleContent(BoxConstraints size) {
    return SizedBox(
      width: size.maxWidth * HomePage.screenWidthMultiplier,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: _buildProfilePicture()),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Column(
              children: [
                _buildUserInfo(), 
                SizedBox(height: 10),
                Expanded(child: _buildWishlist(size: size, products: staticProducts))]),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(body: LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomAppBar(
                size: constraints,
                title: "    My Account",
                trailing: Icon(Icons.edit, color: Colors.grey, size: 26)),
            SizedBox(height: 15),
            Expanded(child: _buildMiddleContent(constraints)),
            CustomBottomNavBar(constraints.maxWidth, context),
          ],
        );
      },
    ));
  }
}
