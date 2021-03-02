import 'package:flutter/material.dart';
import 'package:pgsk/views/widgets/custom_cart.dart';
import '../../../core/repositories/data_repositories/entities_repository.dart';

import '../../../core/entities/product.dart';
import '../home_screen/custom_app_bar.dart';
import '../home_screen/custom_nav_bar.dart';
import '../home_screen/homepage.dart';
import 'product_card_category_page.dart';

class CategoryPage extends StatefulWidget {
  static const String routeName = "/category";

  final EntitiesRepository entitiesRepository;

  const CategoryPage(this.entitiesRepository);

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

  List<Product> _products;

  @override
  void initState() { 
    super.initState();
    widget.entitiesRepository.fetchAllProducts().then(
      (products) => setState(() { _products = products;})
    ).catchError((error) => setState(() =>_products = List<Product>()));
  }

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

  Widget _buildMiddleContent(BoxConstraints size) {
    final double desiredWidth = size.maxWidth * HomePage.screenWidthMultiplier;

    return SizedBox(
    width: desiredWidth,
    child: ListView(
      children: [
        ..._products.map((product) => 
              ProductCardCategoryPage(
                product: product, 
                width: size.maxWidth,
                height: size.maxHeight * 0.2,
                )).toList(),]
          ),
      );
  } 

  @override
  Widget build(BuildContext context) {
    ctx = context;
    if (_products == null || _products.isEmpty) return SizedBox();
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
                CustomAppBar(
                  size: constraints, 
                  title: _title, 
                  trailing: CustomCart()),
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