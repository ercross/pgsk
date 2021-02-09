import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'views/screens/home_screen/homepage.dart';
import 'views/screens/secondary_splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, ));
  runApp(PGSK());
}

class PGSK extends StatelessWidget {
  static const String primaryFont = 'Montserrat';

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'PGSK',
      theme: cookTheme(),
      home: SecondarySplashScreen(),
      routes: {
        HomePage.routeName: (ctx) => HomePage(),
        SecondarySplashScreen.routeName: (ctx) => SecondarySplashScreen(),
      },
    );
  }
  
  ///cookTheme prepares PGSK theme
  ///This method was prepared to avoid the problem described here.
  ///The context passed in PGSK().build(context) contains Flutter default theme
  ///This method was extracted out to override this by avoid call to Theme.of(context) in the method
  ThemeData cookTheme() {
    const Color primaryColorGradient1 = Color(0xFFEC5F23);
    const Color primaryColorGradient2 = Color(0xFFEC2123);
    const Color accentColor = Color(0xFFEC2D23);
    const Color black = Colors.black;
    const Color grey = Colors.grey;
    const Color white = Colors.white;

    TextTheme textTheme = ThemeData.light().textTheme.copyWith(
        headline5: TextStyle(
          color: white,
          fontFamily: primaryFont,
          fontWeight: FontWeight.w900
        ),
        headline6: TextStyle(
          color: black,
          fontFamily: primaryFont,
          fontWeight: FontWeight.w700
        ),
        bodyText2: TextStyle(
          color: primaryColorGradient2,
          fontFamily: primaryFont,
          fontWeight: FontWeight.w400
        ),
        bodyText1: TextStyle(
          color: white,
          fontFamily: primaryFont,
          fontWeight: FontWeight.w700
        ),
        subtitle2: TextStyle(
          color: grey,
          fontFamily: primaryFont,
          fontWeight: FontWeight.w500
        ),
        subtitle1: TextStyle(
          color: black,
          fontFamily: primaryFont,
          fontWeight: FontWeight.w300
        ),
        button: TextStyle(
          color: primaryColorGradient1,
          fontFamily: primaryFont,
          fontWeight: FontWeight.w500
        ),
      );

    return ThemeData(
      primaryColor: primaryColorGradient1,
      accentColor: accentColor,
      splashColor: primaryColorGradient2,
      primaryColorLight: primaryColorGradient2,
      textTheme: textTheme,

    );
  }
}
