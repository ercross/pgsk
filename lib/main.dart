import 'package:flutter/material.dart';

import 'views/screens/home_screen/homepage.dart';

void main() {
  runApp(PGSK());
}

class PGSK extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PGSK',
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Colors.red,
              fontFamily: 'Roboto',
              fontSize: 15,            
            ),
          ),
        appBarTheme: AppBarTheme(
          elevation: 0, 
          color: Colors.white,
          textTheme: ThemeData.dark().textTheme.copyWith(
            headline6: TextStyle(
              color: Colors.red,
              fontFamily: 'BlackHanSans',
              fontSize: 25,            
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.red,
            opacity: 1,
            size: 30,
          )),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey.withOpacity(0.3),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(fontFamily: 'BigShouldersDisplay,' ,color: Colors.black, fontSize: 13),
          selectedLabelStyle: TextStyle(fontFamily: 'BigShouldersDisplay',color: Colors.black, fontSize: 13),
          selectedIconTheme: IconThemeData(
            color: Colors.red,
            opacity: 1,
            size: 25,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.red,
            opacity: 1,
            size: 25
          ),
        ),
        buttonColor: Colors.red,
        buttonBarTheme: ButtonBarThemeData(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.all(8),
          mainAxisSize: MainAxisSize.max,
          buttonTextTheme: ButtonTextTheme.accent,
          buttonHeight: 17
        ),
        fontFamily: 'BlackHanSans',
        snackBarTheme: SnackBarThemeData(
          actionTextColor: Colors.red,
          backgroundColor: Colors.black26,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          contentTextStyle: TextStyle(
            color: Colors.red, 
            fontSize: 11,
            fontStyle: FontStyle.italic
          )
        ),
        primaryColor: Colors.black,
        accentColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(child: HomePage()),
    );
  }
}
