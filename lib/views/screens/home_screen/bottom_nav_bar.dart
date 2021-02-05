import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home"),
      BottomNavigationBarItem(
        icon: Icon(Icons.shop),
        label: "Shop"),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_box),
        label: "My Account"),
      BottomNavigationBarItem(
        icon: Icon(Icons.web),
        label: "Blog"),
      BottomNavigationBarItem(
        icon: Icon(Icons.contact_mail),
        label: "Contact Us"),
    ],);
  }
}
