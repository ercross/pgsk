import 'package:flutter/material.dart';
import 'package:pgsk/core/entities/product.dart';
import 'package:pgsk/views/screens/category_screen/product_card_category_page.dart';
import 'package:pgsk/views/screens/home_screen/homepage.dart';

import '../../main.dart';
import 'home_screen/custom_app_bar.dart';

///DynamicProductsPage displays list of products passed into its route argument.
///A Map<String, dynamic> containing List<Product>, pageTitle must be passed to Navigator.push,
///Where the static variables, @argumentProductsKey and @argumentTitleKey, are the respective keys
class DynamicProductsPage extends StatelessWidget {
  static const String argumentProductsKey = "products";
  static const String argumentTitleKey = "title";
  static const String routeName = "/dynamic-products";

  ///DynamicProductsPage displays list of products passed into its route argument
  ///List<Product> must be passed to Navigator.push
  const DynamicProductsPage();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final List<Product> products = arguments[argumentProductsKey];
    final String pageTitle = arguments[argumentTitleKey];

    return PGSK.buildFullPage(
        child: LayoutBuilder(
            builder: (_, constraints) => SizedBox(
                height: constraints.maxHeight,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomAppBar(
                        size: constraints,
                        title: pageTitle,
                        leading: GestureDetector(
                          child: Icon(Icons.arrow_back_ios, color: Colors.grey),
                          onTap: () => Navigator.of(context).pop(),
                        ),
                        trailing: SizedBox(),
                      ),
                      Expanded(
                          child: products.isNotEmpty
                              ? products
                                  .map((product) => ProductCardCategoryPage(
                                        height: constraints.maxHeight * 0.2,
                                        width: constraints.maxWidth *
                                            HomePage.screenWidthMultiplier,
                                        product: product,
                                      ))
                              : Center(
                                  child: Text("No Products Found",
                                      textAlign: TextAlign.center,
                                      style: PGSK.homepageTexts
                                          .copyWith(color: Colors.grey))))
                    ]))));
  }
}
