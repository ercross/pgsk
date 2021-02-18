import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/providers/bottom_nav_bar_active_icon.dart';
import '../category_screen/category_screen.dart';
import '../search_screen/search_screen.dart';
import '../explore_screen/explore_screen.dart';
import '../user_account_screen/user_account_screen.dart';
import 'homepage.dart';

class CustomBottomNavBar extends StatelessWidget {
  final double maxWidth;
  final BuildContext currentPageContext;
  const CustomBottomNavBar(this.maxWidth, this.currentPageContext);

  Widget _buildNavBarItem({
    @required IconData icon,
    @required bool isActive,
    @required Function onPressed,
    @required BuildContext context,
    @required String label
  }) {

    return IconButton(
      padding: EdgeInsets.all( 0),
      icon: isActive
        ? Container(
          height: 60, 
          width: 60,
          child: Icon(icon, color: Colors.white, size: 25),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorLight,
              ]
            ),
          ))
        : Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon),
            Expanded(child: Text(label, textAlign: TextAlign.center, style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10)))
          ],
        ), 
      color: isActive ? Colors.white :Colors.black, 
      iconSize: isActive ? 60 : 22,
      onPressed: isActive ? (){} : onPressed,
    );
  }
      

  @override
  Widget build(BuildContext context) {
    final BottomNavBarActiveIcon activeIcon =
        Provider.of<BottomNavBarActiveIcon>(context);

    final Widget _background = Container(
      width: maxWidth,
      height: 60,
      color: Colors.white,
    );

    final Widget _navBarIcons = Positioned(
              left: maxWidth * 0.075, //enables the icons placed at the center
              width: maxWidth * 0.85,
              bottom: 10,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  _buildNavBarItem(
                    label: "Home",
                    context: context,
                    onPressed: () {
                      activeIcon.changeValue(0);
                      Navigator.of(currentPageContext).pushReplacementNamed(HomePage.routeName);
                    } ,
                    icon: Icons.home,
                    isActive: activeIcon.value == 0,
                  ),
                  _buildNavBarItem(
                    label: "Category",
                    icon: Icons.category,
                    context: context,
                    onPressed: () {
                      activeIcon.changeValue(1);
                      Navigator.of(currentPageContext).pushReplacementNamed(CategoryPage.routeName);
                    },
                    isActive: activeIcon.value == 1,
                  ),
                  _buildNavBarItem(
                    label: "Explore",
                    icon: Icons.radio_button_checked_rounded,
                    context: context,
                    onPressed: () {
                      activeIcon.changeValue(2);
                      Navigator.of(currentPageContext).pushReplacementNamed(ExplorePage.routeName);
                    },
                    isActive: activeIcon.value == 2,
                  ),
                  _buildNavBarItem(
                    label: "Search",
                    icon: Icons.search,
                    context: context,
                    onPressed: () {
                      activeIcon.changeValue(3);
                      Navigator.of(currentPageContext).pushReplacementNamed(SearchPage.routeName);
                    },
                    isActive: activeIcon.value == 3,
                  ),
                  _buildNavBarItem(
                    label: "Account",
                    icon: Icons.person_pin,
                    context: context,
                    onPressed: () {
                      activeIcon.changeValue(4);
                      Navigator.of(currentPageContext).pushReplacementNamed(UserAccountPage.routeName);
                    },
                    isActive: activeIcon.value == 4,
                  )
                ],
              ));

    return Stack(
        clipBehavior: Clip.none,
        fit: StackFit.passthrough,
        overflow: Overflow.visible,
        children: [
          _background,
          _navBarIcons          
        ]);
  }
}
