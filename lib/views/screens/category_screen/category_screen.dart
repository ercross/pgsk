import 'package:flutter/material.dart';
import 'package:pgsk/views/screens/category_screen/product_card_category_page.dart';
import 'package:pgsk/views/screens/home_screen/homepage.dart';
import '../../../core/entities/product.dart';
import '../../../core/entities/product_category.dart';

import '../home_screen/custom_app_bar.dart';
import '../home_screen/custom_nav_bar.dart';

class CategoryPage extends StatefulWidget {
  static const String routeName = "/category";

  const CategoryPage();

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  
  String _title = "Antivirus Protection";

  final List<String> categories = [
    "   All    ",
    "Antivirus Protection",
    "Mobile Solutions",
    "Business Solutions",
    "Family Solutions"
  ];

  static BuildContext ctx;

  Widget _buildCategoryBox(int index, String category) {
    bool isActive = index == currentlyActive;
    return GestureDetector(
      onTap: () => setState(() {
        _title = category;
        currentlyActive = index;
      } ),
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isActive ? null : Colors.white,
              gradient: isActive 
                          ? LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(ctx).primaryColor,
                                Theme.of(ctx).primaryColorLight,
                              ],
                            )
                            : null,
        ),
        child: Center(
          child: Text(category, 
            textAlign: TextAlign.center, 
            style: Theme.of(ctx).textTheme.caption.copyWith(color: isActive ? Colors.white : Colors.black)),
        ),
      ),
    );
  }

  int currentlyActive = 1;
  Widget _buildCategoriesListView(BoxConstraints size) => SizedBox(
    width: size.maxWidth,
    height: size.maxHeight * 0.08,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _buildCategoryBox(0, categories[0]),
        _buildCategoryBox(1, categories[1]),
        _buildCategoryBox(2, categories[2]),
        _buildCategoryBox(3, categories[3]),
        _buildCategoryBox(4, categories[4])
      ]
    ),
  );

  Widget _buildFilterButton() => GestureDetector(
    onTap: () {},
    child:Container(
      height: 30,
      width: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(ctx).primaryColor,
                Theme.of(ctx).primaryColorLight,
              ],
          )
      ),
      child: Icon(Icons.filter_tilt_shift_rounded, color: Colors.white)
  ));

  static const String prefix = "assets/images/";
    static final List<Product> _products = [
      Product(
        id: 1.toString(),
        name: "Avast Antivirus",
        price: 40,
        specification: "",
        description: "",
        categoryName: "Antivirus Protection",
        imageUrl: prefix + "product_1_avast.png"
      ),

      Product(
        id: 2.toString(),
        name: "Quick Heal Antivirus",
        price: 50,
        specification: "",
        description: "",
        categoryName: "Internet Protection",
        imageUrl: prefix + "product_2_quickheal.png"
      ),
    ];

  final List<Product> _moreProducts = [
    ..._products,
    ..._products,
    ..._products,
    ..._products,
    ..._products,
    ..._products,
  ];

  Widget _buildMiddleContent(BoxConstraints size) {
    final double desiredWidth = size.maxWidth * HomePage.screenWidthMultiplier;
    final double widthPerRow = desiredWidth / 2.1; //the 0.1 accounts for padding and spacing 

    return SizedBox(
    width: desiredWidth,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: widthPerRow,
          child: ListView(
            children: _moreProducts.map((product) => 
              ProductCardCategoryPage(product: product, width: size.maxWidth)).toList(),
          ),
        ),
        SizedBox(
          width: widthPerRow,
          child: ListView(
            children: [
              Container(color: Colors.white, height: size.maxHeight * 0.04),
              ..._moreProducts.map((product) => 
              ProductCardCategoryPage(product: product, width: size.maxWidth)).toList()
            ] 
          ),
        )
      ],
    ),
  );
  } 

  @override
  Widget build(BuildContext context) {
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
                CustomAppBar(size: constraints, title: _title, trailing: _buildFilterButton()),
                _buildCategoriesListView(constraints),
                Expanded(child: _buildMiddleContent(constraints)),
                CustomBottomNavBar(constraints.maxWidth, context),
              ],
            )
          );
        },
      )
    );
  }
}