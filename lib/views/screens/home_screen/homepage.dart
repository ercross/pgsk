import 'package:flutter/material.dart';
import '../../../core/entities/product_category.dart';
import '../../../core/entities/product.dart';
import 'custom_app_bar.dart';
import '../../widgets/homepage_product_card.dart';

import '../../../main.dart';
import 'custom_nav_bar.dart';

class HomePage extends StatelessWidget {
  HomePage();

  //multiplying this factor by the total screen width gives the desired display width for the homepage middle contents
  static const double screenWidthMultiplier = 0.85;
  static const String routeName = "homepage";

  Widget _buildMiddleContent ({@required BuildContext ctx, @required BoxConstraints size})=> SizedBox(
    width: size.maxWidth * screenWidthMultiplier,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDisplayTV(size: size),
        SizedBox(height: 8,),
        _buildCategoriesSection(),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Text("Special Sales Offers", style: PGSK.homepageTexts,),
              Expanded(child: SizedBox()),
              Text("VIEW ALL", style: PGSK.homepageTexts.copyWith(fontWeight: FontWeight.w600, fontSize: 12))
            ],
          ),
        ),
        _buildProductList(size)    
      ]
    ),
  );

  Widget _buildProductList(BoxConstraints size) {
    const String prefix = "assets/images/";
    final List<Product> products = [
      Product(
        id: 1.toString(),
        name: "Avast Antivirus",
        price: 40,
        specification: "",
        description: "",
        category: ProductCategory(id: 1.toString(), name: "Antivirus Protection"),
        imageUrl: prefix + "product_1_avast.png"
      ),
      Product(
        id: 2.toString(),
        name: "Quick Heal Antivirus",
        price: 50,
        specification: "",
        description: "",
        category: ProductCategory(id: 2.toString(), name: "Internet Protection"),
        imageUrl: prefix + "product_2_quickheal.png"
      ),
      Product(
        id: 3.toString(),
        name: "Kaspersky Antivirus",
        price: 60,
        specification: "",
        description: "",
        category: ProductCategory(id: 3.toString(), name: "Antivirus Protection"),
        imageUrl: prefix + "product_3_kaspersky.png"
      ),
    ];
    return SizedBox(
      height: size.maxHeight * 0.33,
      width: size.maxWidth * screenWidthMultiplier,
      child: ListView(
            children: products.map<HomePageProductCard>((product) => HomePageProductCard(
              product: product,
              size: size,)).toList(),
          ),
    );
  }

  Widget _buildCategoriesSection() {
    const String prefix = "assets/images/";
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text("Categories", style: PGSK.homepageTexts),
            Expanded(child: SizedBox(),),
            Text("VIEW ALL", style: PGSK.homepageTexts.copyWith(fontWeight: FontWeight.w600, fontSize: 12))
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOvalShapedContainer(isActive: false, imageUrl: prefix + "family_solution_circled.png", imageLabel: "Family"),
              _buildOvalShapedContainer(isActive: true, imageUrl: prefix + "business_solution_circled.png", imageLabel: "Business"),
              _buildOvalShapedContainer(isActive: false, imageUrl: prefix + "mobile_solution_circled.png", imageLabel: "Mobile"),
              _buildOvalShapedContainer(isActive: false, imageUrl: prefix + "internet_security_circled.png", imageLabel: "Internet")
            ]
          ),
        )
      ],
    );
  }
  static BuildContext ctx;
  static Size size; //pageWidth was used to size this containers to avoid ViewOverFlow error on smaller screen sizes
  Widget _buildOvalShapedContainer({
    @required bool isActive,
    @required String imageUrl,
    @required String imageLabel,
  }) {
    const double horizontalMargin = 8;
    return Container(
      height: size.height * 0.11,
      width: ((size.width * screenWidthMultiplier) - (horizontalMargin * 6)) / 4.2,
      margin: EdgeInsets.symmetric(vertical: 13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imageUrl),
          Text(imageLabel, style: Theme.of(ctx).textTheme.caption.copyWith(fontSize: 9, color: isActive ? Colors.white : Colors.black))
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        color: isActive 
                ? null 
                : Colors.grey,

        gradient: isActive 
                ? LinearGradient(
                    colors: [
                      Theme.of(ctx).primaryColor,
                      Theme.of(ctx).primaryColorLight
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                  ) 
                : null,
      ),
    );
  }

  Widget _buildDisplayTV({@required BoxConstraints size}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 12),
          width: size.maxWidth * screenWidthMultiplier,
          height: size.maxHeight * 0.22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset("assets/images/special_deal.png", fit: BoxFit.fill)
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            Container(height: 3, width: 10, color: Theme.of(ctx).primaryColor),
            Container(height: 3, width: 10, color: Colors.grey),
            Container(height: 3, width: 10, color: Colors.grey),
            Container(height: 3, width: 10, color: Colors.grey)
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    ctx = context;

    return Scaffold(
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            color: Colors.grey[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: constraints.maxHeight * 0.065),
                CustomAppBar(constraints.maxWidth),
                Expanded(child: _buildMiddleContent(ctx: ctx, size: constraints)),
                CustomBottomNavBar(constraints.maxWidth),
              ],
            )
          );
        },
      )
    );
  }
}
