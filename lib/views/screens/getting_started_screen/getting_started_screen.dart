import 'package:flutter/material.dart';

import '../../widgets/gradient_colored_long_action_button.dart';
import '../authentication_screen/authentication_page.dart';
import '../home_screen/homepage.dart';

class GettingStartedPage extends StatelessWidget {
  static const String routeName = "/getting_started";

  const GettingStartedPage();

  @override
  Widget build(BuildContext context) {

    final MediaQueryData mQ = MediaQuery.of(context);
    final double pageHeight = mQ.size.height;
    final double pageWidth = mQ.size.width;

    final Widget _background = Positioned(
              left: 0,
              top: 0,
              width: pageWidth,
              height: pageHeight,
              child: Image.asset("assets/images/splash_screen_background.png",
                  fit: BoxFit.fill));

    final Widget _closeIcon = Positioned(
      top: pageHeight * 0.02,
      left: pageWidth * 0.02,
      child: IconButton(
        icon: Icon(Icons.close, color: Colors.white, size: 18,),
        onPressed: () => Navigator.of(context).pushReplacementNamed(HomePage.routeName)
      )
    );
    
    final Widget _pgskIcon = Positioned(
            top: pageHeight * 0.05,
            right: pageWidth * 0.2,
            left: pageWidth * 0.2,
            child: Image.asset(
              "assets/images/launch_icon.png",
              fit: BoxFit.scaleDown,
            ),
          );

    final Widget _middleWord = Positioned(
      top: pageHeight * 0.47,
      right: pageWidth * 0.1,
      left: pageWidth * 0.1,
      child: Text("SIGN UP FOR PGSK\nFREE SECURITY PROTECTION\nDOWNLOADS", 
        textAlign: TextAlign.center, 
        style: Theme.of(context).textTheme.headline6),
    );

    final Widget _getStartedButton = Positioned(
            bottom: pageHeight * 0.03,
            left: pageWidth * 0.05,
            right: pageWidth * 0.05,
            child: GradientColoredLongActionButton(
                  text: "GET STARTED",
                  onPressed: () => Navigator.of(context).pushReplacementNamed(AuthenticationPage.routeName)
                ),
            );

    return Scaffold(
      body: Stack(
        children: [
          _background,
          _closeIcon,
          _pgskIcon,
          _middleWord,
          _getStartedButton,
        ],
      ),
    );
  }
}