import 'package:flutter/material.dart';
import 'package:pgsk/views/screens/dynamic_products_screen.dart';
import '../../../controllers/providers/bottom_nav_bar_active_icon.dart';
import 'package:provider/provider.dart';
import '../../../core/repositories/data_repositories/entities_repository.dart';
import '../category_screen/category_screen.dart';

import '../../../core/entities/product_category.dart';
import '../../../main.dart';
import 'homepage.dart';
import 'product_card_homepage.dart';

class HomePageBrandsSection extends StatefulWidget {
  final EntitiesRepository entitiesRepository;
  final double allowedWidth;
  final double allowedHeight;

  HomePageBrandsSection(
      {@required this.entitiesRepository,
      @required this.allowedHeight,
      @required this.allowedWidth});

  @override
  _HomePageBrandsSectionState createState() => _HomePageBrandsSectionState();
}

class _HomePageBrandsSectionState extends State<HomePageBrandsSection> {
  ///activeCategory is the category whose products are currently on display on the homepage
  int _activeCategory = 0;

  List<ProductCategory> _brands;
  ProductCategory _brandCurrentlyOnDisplay;

  //TODO: print error type on screen
  @override
  void initState() {
    super.initState();
    widget.entitiesRepository.fetchAllProductBrands().then((fetchedCategories) {
      setState(() {
        _brands = fetchedCategories;
        _brandCurrentlyOnDisplay = _brands[_activeCategory];
      });
    }).catchError((error) => _brands = []);
  }

  Widget _buildCurrentCategoryName() {
    return Row(
      children: [
        Text(
          _brandCurrentlyOnDisplay.name,
          style: PGSK.homepageTexts,
        ),
        Expanded(child: SizedBox()),
        Text("VIEW PRODUCTS",
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.w700, fontSize: 12))
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
                Expanded(child: _buildBrandProducts()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandProducts() {
    return ListView(
      children: _brandCurrentlyOnDisplay.products
          .map<ProductCardHomePage>((product) => ProductCardHomePage(
                onActionButtonPressed: () => Navigator.of(context).pushNamed(
                    DynamicProductsPage.routeName,
                    arguments: widget.entitiesRepository
                        .fetchBrandProducts(_brandCurrentlyOnDisplay.name)),
                product: product,
                width: widget.allowedWidth,
                height: widget.allowedHeight * 2,
              ))
          .toList(),
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
        width: (widget.allowedWidth * HomePage.screenWidthMultiplier) / 3.5,
        margin: EdgeInsets.only(right: 5, left: 5, top: 5),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(imageUrl)),
            Expanded(
              child: Text(imageLabel,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontSize: 9,
                        color: Colors.white,
                      )),
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
    List<Widget> categoriesW = [];
    for (int i = 0; i < _brands.length; i++) {
      categoriesW.add(_buildShapedCategory(
          imageLabel: _brands[i].name,
          imageUrl: _brands[i].imageUrl,
          index: i));
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

  Widget _buildCategoriesSectionHeader() {
    return Row(
      children: [
        Text("Brands We Sell", style: PGSK.homepageTexts),
        Expanded(
          child: SizedBox(),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(CategoryPage.routeName);
            Provider.of<BottomNavBarActiveIcon>(context, listen: false)
                .changeValue(1);
          },
          child: Text("VIEW ALL",
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.headline4.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  )),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_brands == null || _brands.isEmpty) return SizedBox();
    _brandCurrentlyOnDisplay = _brands[_activeCategory];
    return Column(
      children: [
        _buildCategoriesSectionHeader(),
        _buildShapedCategories(),
        SizedBox(
          height: 10,
        ),
        Expanded(child: _buildCategoryContent())
      ],
    );
  }
}
