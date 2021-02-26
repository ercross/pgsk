import 'package:flutter/material.dart';

import '../../../data/impl_data_repositories/impl_image_repository.dart';
import '../../../main.dart';
import '../category_screen/category_screen.dart';
import 'custom_app_bar.dart';
import 'custom_nav_bar.dart';
import 'homepage_categories_section.dart';
import 'tv_display.dart';

class HomePage extends StatelessWidget {
  HomePage();

  //multiplying this factor by the total screen width gives the desired display width for the homepage middle contents
  static const double screenWidthMultiplier = 0.85;
  static const String routeName = "homepage";

  //The primary purpose of these properties is to provide dimension to homepage TV images
  static double deviceWidth;
  static double deviceHeight;

  static BuildContext ctx;

  Widget _buildMiddleContent({@required BoxConstraints size}) => SizedBox(
        width: size.maxWidth * screenWidthMultiplier,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              TVDisplay(
                imageRepository: ImageRepositoryImpl(),
                allowedWidth: size.maxWidth * screenWidthMultiplier,
                allowedHeight: size.maxHeight * 0.22,
              ),

              SizedBox(height: 8,),
              
              Expanded(child: _buildCategoriesSection())
            ]),
      );

  Widget _buildCategoriesSectionHeader () {
    return Row(
          children: [
            Text("Categories", style: PGSK.homepageTexts),
            Expanded(
              child: SizedBox(),
            ),
            FlatButton(
                onPressed: () => Navigator.of(ctx)
                    .pushReplacementNamed(CategoryPage.routeName),
                child: Text("VIEW ALL",
                    style: Theme.of(ctx).textTheme.headline4
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 12, )))
          ],
        );
  }

  Widget _buildCategoriesSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCategoriesSectionHeader(),
        HomePageCategoriesSection()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ctx = context;
    deviceHeight = size.height;
    deviceWidth = size.width;

    return Scaffold(body: LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            color: Colors.grey[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomAppBar(
                    size: constraints,
                    title: "Discover",
                    trailing: Icon(Icons.shopping_cart)),
                Expanded(child: _buildMiddleContent(size: constraints)),
                CustomBottomNavBar(constraints.maxWidth, context),
              ],
            ));
      },
    ));
  }
}
