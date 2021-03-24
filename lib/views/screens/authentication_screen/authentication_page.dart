import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class AuthenticationPage extends StatefulWidget {
  static const String routeName = "/authentication";

  AuthenticationPage();

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  int currentTab = 0;
  PageController _controller = PageController(initialPage: 0);

  Widget _buildTab(
      {@required String label,
      @required double pageWidth,
      @required bool isActive,
      @required int tabIndex}) {
    return Container(
        width: pageWidth / 2,
        decoration: BoxDecoration(
          color: isActive ? Colors.white70 : Colors.white,
          border: tabIndex == 1
              ? Border(left: BorderSide(color: Colors.white))
              : Border(right: BorderSide(color: Colors.white)),
        ),
        child: TextButton(
          child: Text(label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color:
                      isActive ? Theme.of(context).accentColor : Colors.grey)),
          onPressed: () => setState(() {
            currentTab = tabIndex;
            _controller.jumpToPage(tabIndex);
          }),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return PGSK.buildFullPage(child: LayoutBuilder(
      builder: (_, constraints) {
        return Column(
          children: [
            Stack(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              fit: StackFit.passthrough,
              children: [
                Image.asset(
                  "assets/images/splash_screen_background.png",
                  fit: BoxFit.fitWidth,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.2,
                ),
                Positioned(
                  top: constraints.maxHeight * 0.14,
                  right: 0,
                  left: 0,
                  child: Row(
                    children: [
                      _buildTab(
                          pageWidth: constraints.maxWidth,
                          label: "Sign In",
                          isActive: currentTab == 0,
                          tabIndex: 0),
                      _buildTab(
                          pageWidth: constraints.maxWidth,
                          label: "Sign Up",
                          isActive: currentTab == 1,
                          tabIndex: 1)
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView(
                onPageChanged: (newTabIndex) =>
                    setState(() => currentTab = newTabIndex),
                controller: _controller,
                children: [
                  SignInTab(
                    viewportHeight: constraints.maxHeight * 0.9,
                    viewportWidth: constraints.maxWidth,
                    pageController: _controller,
                  ),
                  SignUpTab(
                    viewportHeight: constraints.maxHeight * 0.9,
                    viewportWidth: constraints.maxWidth,
                    pageController: _controller,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ));
  }
}
