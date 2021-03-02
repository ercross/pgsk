import 'package:flutter/material.dart';
import '../../../core/repositories/data_repositories/entities_repository.dart';
import '../category_screen/category_screen.dart';

import '../../../core/entities/product_category.dart';
import '../../../main.dart';
import 'homepage.dart';
import 'product_card_homepage.dart';

class HomePageCategoriesSection extends StatefulWidget {
  final EntitiesRepository entitiesRepository;
  final double allowedWidth;
  final double allowedHeight;

  HomePageCategoriesSection({
    @required this.entitiesRepository,
    @required this.allowedHeight, 
    @required this.allowedWidth
  });

  @override
  _HomePageCategoriesSectionState createState() =>
      _HomePageCategoriesSectionState();
}

class _HomePageCategoriesSectionState extends State<HomePageCategoriesSection> {

  ///activeCategory is the category whose products are currently on display on the homepage
  int _activeCategory = 0;


  List<ProductCategory> _categories;
  ProductCategory _categoryCurrentlyOnDisplay;

  //TODO: print error type on screen
  @override
  void initState() { 
    super.initState();
    widget.entitiesRepository.fetchAllProductCategories()
      .then((fetchedCategories) { 
        setState(() {
          _categories = fetchedCategories;          
          _categoryCurrentlyOnDisplay = _categories[_activeCategory];
        });
        })
      .catchError((error) => _categories = List<ProductCategory>());
  }

  Widget _buildCurrentCategoryName() {
    return Row(
      children: [
        Text(
          _categoryCurrentlyOnDisplay.name,
          style: PGSK.homepageTexts,
        ),
        Expanded(child: SizedBox()),
        Text("VIEW PRODUCTS",
            style: Theme.of(context).textTheme.headline4
                .copyWith(fontWeight: FontWeight.w700, fontSize:12))
      ],
    );
  }

  Widget _buildCategoryContent() {
    return LayoutBuilder(
      builder: (_, constraint) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: constraint.maxHeight,
            width: constraint.maxWidth,
            child: Column(
              children: [
                _buildCurrentCategoryName(),
                Expanded(child: _buildCategoryProducts()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryProducts() {
    return ListView(
          children: _categoryCurrentlyOnDisplay.products.map<ProductCardHomePage>(
            (product) => ProductCardHomePage(
              product: product,
              width: widget.allowedWidth,
              height: widget.allowedHeight * 2,
              )).toList(),
        );
  
  }

  Widget _buildShapedCategory({
    @required int index,
    @required String imageUrl,
    @required String imageLabel,
  }) {
    final bool isActive = index == _activeCategory;

    return GestureDetector(
      onTap: () => setState(() => _activeCategory = index),
      child: Container(
        //The size of the balls is controlled by this width and buildShapedCategories.SizedBox().height
        width: (widget.allowedWidth * HomePage.screenWidthMultiplier) / 3.9,
        margin: EdgeInsets.only(right: 5, left: 5, top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(imageUrl),
            Expanded(
              child: Text(imageLabel,
                  style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 9, color: Colors.white,)),
            )
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
    List<Widget> categoriesW = List<Widget>();
    for(int i=0; i<_categories.length; i++) {
      categoriesW.add(_buildShapedCategory(
        imageLabel: _categories[i].name,
        imageUrl: _categories[i].imageUrl,
        index: i
      ));
    }
    return SizedBox(
      width: widget.allowedWidth,
      height: widget.allowedHeight * 0.2,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categoriesW,
          ),
    );
  }

  Widget _buildCategoriesSectionHeader () {
    return Row(
          children: [
            Text("Categories", style: PGSK.homepageTexts),
            Expanded(
              child: SizedBox(),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushReplacementNamed(CategoryPage.routeName),
              child: Text("VIEW ALL", textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.headline4
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 12, )),
            )
          ],
        );
  }

  @override
  Widget build(BuildContext context) {
    if(_categories == null || _categories.isEmpty) return SizedBox();
    _categoryCurrentlyOnDisplay = _categories[_activeCategory];
    return Column(
      children: [
        _buildCategoriesSectionHeader(),
        _buildShapedCategories(),
        SizedBox(height: 10,),
        Expanded(child: _buildCategoryContent())
      ],
    );
  }
}

