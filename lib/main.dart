import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'views/screens/authentication_screen/authentication_page.dart';
import 'views/screens/home_screen/homepage.dart';
import 'views/screens/onboarding_screen/onboarding_page.dart';
import 'views/screens/secondary_splash_screen.dart';
import 'views/widgets/on_page_loading_spinner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(PGSK());
}

class PGSK extends StatelessWidget {
  static const String primaryFont = 'Montserrat';

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'PGSK',
      theme: cookTheme(),
      home: GestureDetector(
      onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      child: SafeArea(child: AuthenticationPage())),
      routes: {
        OnpageLoadingSpinner.routeName: (ctx) => OnpageLoadingSpinner(),
        HomePage.routeName: (ctx) => HomePage(),
        SecondarySplashScreen.routeName: (ctx) => SecondarySplashScreen(),
        OnboardingPage.routeName: (ctx) => OnboardingPage(),
        AuthenticationPage.routeName: (ctx) =>  AuthenticationPage(),
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
      //used for onboarding page product range topics
        headline4: TextStyle(
          color: accentColor,
          fontFamily: primaryFont,
          fontSize: 20,
          fontWeight: FontWeight.w600
        ),
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
          color: white,
          fontSize: 12,
          fontFamily: primaryFont,
          fontWeight: FontWeight.w600
        ),
        bodyText1: TextStyle(
          color: white,
          fontFamily: primaryFont,
          fontWeight: FontWeight.w600
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
        //used for authentication page OvalShapedTextField.FieldFor
        caption: TextStyle(
          color: black,
          fontFamily: primaryFont,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        button: TextStyle(
          color: primaryColorGradient1,
          fontFamily: primaryFont,
          fontWeight: FontWeight.w500
        ),
      );

    final TabBarTheme tabBarTheme = TabBarTheme(indicatorSize: TabBarIndicatorSize.tab);

    return ThemeData(
      primaryColor: primaryColorGradient1,
      accentColor: accentColor,
      splashColor: primaryColorGradient2,
      primaryColorLight: primaryColorGradient2,
      textTheme: textTheme,      
      tabBarTheme: tabBarTheme,
    );
  }
}
