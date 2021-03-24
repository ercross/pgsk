import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pgsk/views/screens/dynamic_products_screen.dart';
import 'package:provider/provider.dart';

import 'controllers/cubits/image_cubit/image_cubit.dart';
import 'controllers/providers/bottom_nav_bar_active_icon.dart';
import 'controllers/providers/cart.dart';
import 'controllers/providers/checkout_progress.dart';
import 'controllers/providers/payment_data.dart';
import 'controllers/providers/wishlist.dart';
import 'data/repositories_impl/data_repositories_impl/impl_entities_repository.dart';
import 'data/repositories_impl/data_repositories_impl/impl_image_repository.dart';
import 'data/repositories_impl/services_repositories_impl/e_commerce_services_repository_impl.dart';
import 'views/screens/authentication_screen/authentication_page.dart';
import 'views/screens/category_screen/category_screen.dart';
import 'views/screens/checkout_screen/checkout_screen.dart';
import 'views/screens/checkout_screen/checkout_successful.dart';
import 'views/screens/explore_screen/explore_screen.dart';
import 'views/screens/getting_started_screen/getting_started_screen.dart';
import 'views/screens/home_screen/homepage.dart';
import 'views/screens/onboarding_screen/onboarding_page.dart';
import 'views/screens/search_screen/search_screen.dart';
import 'views/screens/secondary_splash_screen.dart';
import 'views/screens/user_account_screen/user_account_screen.dart';
import 'views/widgets/on_page_loading_spinner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Cart>(
        create: (_) => Cart(ECommerceServicesRepositoryImpl()),
      ),
      ChangeNotifierProvider<BottomNavBarActiveIcon>(
          create: (_) => BottomNavBarActiveIcon()),
      ChangeNotifierProvider<PaymentData>(create: (_) => PaymentData()),
      ChangeNotifierProvider<CheckoutProgress>(
          create: (_) => CheckoutProgress()),
      ChangeNotifierProvider<Wishlist>(
        create: (_) => Wishlist(ECommerceServicesRepositoryImpl()),
      ),
    ],
    child: MultiBlocProvider(providers: [
      BlocProvider<ImageCubit>(
        create: (_) => ImageCubit(ImageRepositoryImpl()),
      )
    ], child: PGSK()),
  ));
}

class PGSK extends StatelessWidget {
  static const String primaryFont = 'Montserrat';
  static const String currency = "\$";
  static const Color primaryColorGradient1 = Color(0xFFEC5F23);
  static const Color primaryColorGradient2 = Color(0xFFEC2123);
  static const Color accentColor = Color(0xFFEC2D23);

  static const TextStyle homepageTexts = TextStyle(
    color: Colors.black,
    fontFamily: primaryFont,
    fontWeight: FontWeight.w800,
    fontSize: 14,
    wordSpacing: 0.5,
  );

  static final bool isIos = Platform.isIOS;

  final Map<String, Widget Function(BuildContext)> _routes = {
    CheckoutSuccessPage.routeName: (_) => CheckoutSuccessPage(),
    CheckoutPage.routeName: (_) => CheckoutPage(),
    UserAccountPage.routeName: (_) => UserAccountPage(),
    SearchPage.routeName: (_) => SearchPage(),
    ExplorePage.routeName: (_) => ExplorePage(),
    CategoryPage.routeName: (_) => CategoryPage(EntitiesRepositoryImpl()),
    GettingStartedPage.routeName: (_) => GettingStartedPage(),
    OnpageLoadingSpinner.routeName: (_) => OnpageLoadingSpinner(),
    HomePage.routeName: (_) => HomePage(),
    SecondarySplashScreen.routeName: (_) => SecondarySplashScreen(),
    OnboardingPage.routeName: (_) => OnboardingPage(),
    AuthenticationPage.routeName: (_) => AuthenticationPage(),
    DynamicProductsPage.routeName: (_) => DynamicProductsPage(),
  };

  final String title = 'PGSK Technologies';

  static Widget buildFullPage({@required Widget child}) => PGSK.isIos
      ? CupertinoPageScaffold(child: SafeArea(child: child))
      : Scaffold(body: child);

  final Widget home = GestureDetector(
    onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
    child: HomePage(),
  );

  Widget _buildForAndroid() => MaterialApp(
        title: title,
        theme: cookAndroidTheme(),
        home: home,
        routes: _routes,
      );

  Widget _buildForIos() => CupertinoApp(
        title: title,
        theme: cookIosTheme(),
        home: home,
        routes: _routes,
      );

  @override
  Widget build(BuildContext context) =>
      isIos ? _buildForIos() : _buildForAndroid();

  CupertinoThemeData cookIosTheme() {
    final CupertinoTextThemeData textTheme = CupertinoTextThemeData(
        primaryColor: accentColor,
        tabLabelTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: primaryFont,
            fontSize: 14,
            fontWeight: FontWeight.w700),
        navActionTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: primaryFont,
            fontSize: 12,
            fontWeight: FontWeight.w700),
        navLargeTitleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: primaryFont,
            fontSize: 20,
            fontWeight: FontWeight.w600),
        navTitleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: primaryFont,
            fontSize: 16,
            fontWeight: FontWeight.w700),
        actionTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: primaryFont,
            fontSize: 13,
            fontWeight: FontWeight.w600),
        textStyle: TextStyle(
            color: Colors.black,
            fontFamily: primaryFont,
            fontSize: 13,
            fontWeight: FontWeight.w600));

    return CupertinoThemeData(
      primaryColor: primaryColorGradient1,
      primaryContrastingColor: accentColor,
      scaffoldBackgroundColor: accentColor.withOpacity(0.4),
      textTheme: textTheme,
    );
  }

  ///cookTheme prepares PGSK theme
  ///This method was prepared to avoid the problem described below.
  ///The context passed in PGSK().build(context) contains Flutter default theme
  ///This method was extracted out to override this by avoiding call to Theme.of(context) in the method
  ThemeData cookAndroidTheme() {
    const Color black = Colors.black;
    const Color grey = Colors.grey;
    const Color white = Colors.white;

    TextTheme textTheme = ThemeData.light().textTheme.copyWith(
          //used for onboarding page product range topics
          headline4: TextStyle(
              color: accentColor,
              fontFamily: primaryFont,
              fontSize: 20,
              fontWeight: FontWeight.w600),
          headline5: TextStyle(
              color: white,
              fontFamily: primaryFont,
              fontWeight: FontWeight.w900),
          headline6: TextStyle(
              color: white,
              fontFamily: primaryFont,
              fontWeight: FontWeight.w600),
          bodyText2: TextStyle(
              color: white,
              fontSize: 12,
              fontFamily: primaryFont,
              fontWeight: FontWeight.w600),
          bodyText1: TextStyle(
              color: white,
              fontSize: 14,
              fontFamily: primaryFont,
              fontWeight: FontWeight.w600),
          subtitle2: TextStyle(
              color: grey,
              fontFamily: primaryFont,
              fontWeight: FontWeight.w800),
          subtitle1: TextStyle(
              color: black,
              fontFamily: primaryFont,
              fontWeight: FontWeight.w300),
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
            fontWeight: FontWeight.w500,
          ),
        );

    final TabBarTheme tabBarTheme =
        TabBarTheme(indicatorSize: TabBarIndicatorSize.tab);

    final AppBarTheme appBarTheme = AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: black, size: 22),
      color: Colors.transparent,
    );

    return ThemeData(
        primaryColor: primaryColorGradient1,
        accentColor: accentColor,
        splashColor: primaryColorGradient2,
        primaryColorLight: primaryColorGradient2,
        textTheme: textTheme,
        tabBarTheme: tabBarTheme,
        appBarTheme: appBarTheme);
  }
}
