import 'package:flutter/material.dart';
import '../../../core/entities/product_category.dart';
import '../../../main.dart';
import '../../widgets/custom_cart.dart';
import '../../../core/repositories/data_repositories/entities_repository.dart';

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
  ///The page title is the currently active category name
  String _pageTitle;

  ///currentlyActiveCategoryID denotes the category whose products are currently on display
  ///ProductCategory.ID is used to map category to their respective products,
  ///especially the category array displayed at the upper part of CategoryPage()
  ///Its value is initialized to the zeroth element in _categories, provided _categories.isNotEmpty
  int _currentlyActiveCategoryID;
  List<ProductCategory> _categories;

  @override
  void initState() {
    super.initState();
    widget.entitiesRepository
        .fetchAllProductCategories()
        .then((categories) => setState(() {
              _categories = categories;
              if (_categories != null && _categories.isNotEmpty) {
                _currentlyActiveCategoryID = _categories[0].id;
                _pageTitle = _categories[0].name;
              }
            }))
        .catchError((error) => setState(() => _categories = []));
  }

  static BuildContext ctx;

  ///_buildCategoryBox builds a category name enclosed in a container.
  ///An array of this is displayed at the upper part of categoryPage, built by @buildHorizontalCategoryNames
  Widget _buildCategoryBox(
      {@required String categoryName, @required int categoryId}) {
    bool isActive = categoryId == _currentlyActiveCategoryID;
    return GestureDetector(
      onTap: () => setState(() {
        _pageTitle = categoryName;
        _currentlyActiveCategoryID = categoryId;
      }),
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
          child: Text(categoryName,
              textAlign: TextAlign.center,
              style: Theme.of(ctx)
                  .textTheme
                  .caption
                  .copyWith(color: isActive ? Colors.white : Colors.black)),
        ),
      ),
    );
  }

  Widget _buildHorizontalCategoryNames(BoxConstraints size) {
    return SizedBox(
      width: size.maxWidth,
      height: size.maxHeight * 0.08,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        ..._categories.map((category) => _buildCategoryBox(
            categoryName: category.name, categoryId: category.id))
      ]),
    );
  }

  ///buildCategoryProducts builds category.product of category.id == currentlyActiveCategoryID
  Widget _buildCategoryProducts(BoxConstraints size) {
    final double desiredWidth = size.maxWidth * HomePage.screenWidthMultiplier;
    ProductCategory currentlyActiveCategory = _categories
        .firstWhere((category) => category.id == _currentlyActiveCategoryID);

    return SizedBox(
      width: desiredWidth,
      child: ListView(children: [
        ...currentlyActiveCategory.products
            .map((product) => ProductCardCategoryPage(
                  product: product,
                  width: size.maxWidth,
                  height: size.maxHeight * 0.2,
                ))
            .toList(),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    if (_categories == null || _categories.isEmpty)
      return PGSK.buildFullPage(
          child:
              Center(child: Card(child: Text("Unable to fetch categories"))));
    else
      return PGSK.buildFullPage(child: LayoutBuilder(
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
                      title: _pageTitle,
                      trailing: CustomCart()),
                  _buildHorizontalCategoryNames(constraints),
                  Expanded(child: _buildCategoryProducts(constraints)),
                  CustomBottomNavBar(constraints.maxWidth, context),
                ],
              ));
        },
      ));
  }
}
