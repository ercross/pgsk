import 'package:flutter/material.dart';
import 'package:pgsk/core/entities/product.dart';

import '../../../core/entities/product_category.dart';
import 'homepage.dart';
import 'product_card_homepage.dart';

class HomePageCategoriesSection extends StatefulWidget {
  final double allowedWidth;
  final double allowedHeight;

  HomePageCategoriesSection({@required this.allowedHeight, @required this.allowedWidth}) ;

  @override
  _HomePageCategoriesSectionState createState() => _HomePageCategoriesSectionState();
}

class _HomePageCategoriesSectionState extends State<HomePageCategoriesSection> {

  final String _prefix = "assets/images/";
  int activeCategory = 0;
  List<ProductCategory> categories;

  Widget _buildProductList(BoxConstraints size) {
    
    return SizedBox(
      height: size.maxHeight * 0.33,
      width: size.maxWidth * HomePage.screenWidthMultiplier,
      child: ListView(
        children: products
            .map<ProductCardHomePage>((product) => ProductCardHomePage(
                  width: size.maxWidth,
                  product: product,
                  height: size.maxHeight,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCategoryContent() {
    Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      Text(
                        "Special Sales Offers",
                        style: PGSK.homepageTexts,
                      ),
                      Expanded(child: SizedBox()),
                      Text("VIEW ALL",
                          style: PGSK.homepageTexts.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 12))
                    ],
                  ),
                ),
              );
  }

  Widget _buildShapedCategory({
    @required int index,
    @required String imageUrl,
    @required String imageLabel,
  }) {
    
    final bool isActive = index == activeCategory;

    return GestureDetector(
      onTap: () =>  setState(() => activeCategory = index),
      child: Container(
        height: widget.allowedHeight * 0.125,
        width: (widget.allowedWidth * HomePage.screenWidthMultiplier) / 4.2,
        margin: EdgeInsets.symmetric(vertical: 13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imageUrl),
            Text(imageLabel,
                style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 9, color: isActive ? Colors.white : Colors.black))
          ],
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? null : Colors.grey,
          gradient: isActive
              ? LinearGradient(colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorLight
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
              : null,
        ),
      ),
    );
  }

  Widget _buildShapedCategories() {
    SizedBox(
          width: widget.allowedWidth,
          child: SingleChildScrollView(
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildShapedCategory(
                      index: 0,
                      imageUrl: _prefix + "family_solution_circled.png",
                      imageLabel: "Family"),

                  _buildShapedCategory(
                      index: 1,
                      imageUrl: _prefix + "business_solution_circled.png",
                      imageLabel: "Business"),

                  _buildShapedCategory(
                      index: 2,
                      imageUrl: _prefix + "mobile_solution_circled.png",
                      imageLabel: "Mobile"),

                  _buildShapedCategory(
                      index: 3,
                      imageUrl: _prefix + "internet_security_circled.png",
                      imageLabel: "Internet")
                ]),
          ),
        );  
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildShapedCategories(),

      ],
    );
  }
}