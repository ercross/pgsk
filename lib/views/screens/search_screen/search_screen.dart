import 'package:flutter/material.dart';
import '../home_screen/homepage.dart';

import '../home_screen/custom_app_bar.dart';
import '../home_screen/custom_nav_bar.dart';

class SearchPage extends StatelessWidget {
  static const String routeName = "/search";

  SearchPage();

  static BuildContext ctx;

  final List<String> searchSuggestions = [
    "Quick Heal Antivirus",
    "Avast Antivirus",
    "Kaspersky Antivirus",
    "Mobile Solutions",
    "Norton Antivirus",
    "Smart Device",
    "Special Deals",
    "Mobile Solutions"
  ];

  Widget _buildASearchSuggestion(String suggestion) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10)),
        child: Text(suggestion,
            textAlign: TextAlign.center,
            style: Theme.of(ctx)
                .textTheme
                .caption
                .copyWith(fontWeight: FontWeight.w500)));
  }

//
  Widget _buildSearchSuggestions(
      List<String> searchSuggestions, BoxConstraints size) {
    List<Widget> rows = [];
    for (int i = 0; i < searchSuggestions.length; i += 2) {
      rows.add(Container(
        height: size.maxHeight * 0.06,
        margin: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildASearchSuggestion(searchSuggestions[i]),
            SizedBox(width: 10),
            _buildASearchSuggestion(searchSuggestions[i + 1]),
          ],
        ),
      ));
    }
    return ListView(children: rows);
  }

  Widget _buildSearchBar(BoxConstraints size) {
    final double rowHeight = size.maxHeight * 0.07;

    final Widget searchBar = Container(
        width: size.maxWidth * HomePage.screenWidthMultiplier,
        height: rowHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow()],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
        padding: EdgeInsets.all(10),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Form(
              child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "      Search Items",
                      labelStyle: Theme.of(ctx)
                          .textTheme
                          .subtitle2
                          .copyWith(fontSize: 12))),
            )));

    final Widget searchButton = Positioned(
        right: 1,
        child: Container(
            height: rowHeight,
            width: size.maxWidth * 0.18,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(ctx).primaryColorLight,
                      Theme.of(ctx).primaryColor,
                    ])),
            child: Center(
                child: IconButton(
              icon: Icon(Icons.search, color: Colors.white, size: 27),
              onPressed: () {},
            ))));

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: rowHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Stack(clipBehavior: Clip.none, children: [
            searchBar,
            searchButton,
          ]),
        ],
      ),
    );
  }

  Widget _buildMiddleContent(BoxConstraints size) {
    return Center(
        child: SizedBox(
            width: size.maxWidth * HomePage.screenWidthMultiplier,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchBar(size),
                Expanded(
                  child: _buildSearchSuggestions(searchSuggestions, size),
                )
              ],
            )));
  }

  Widget _buildFilterButton() => GestureDetector(
      onTap: () {},
      child: Container(
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
              )),
          child: Icon(Icons.filter_tilt_shift_rounded, color: Colors.white)));

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
                title: "Search",
                trailing: _buildFilterButton()),
            SizedBox(
              height: 15,
            ),
            Expanded(child: _buildMiddleContent(constraints)),
            CustomBottomNavBar(constraints.maxWidth, context),
          ],
        );
      },
    ));
  }
}
