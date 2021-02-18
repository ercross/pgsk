import 'package:flutter/cupertino.dart';

class ExplorePageInfo with ChangeNotifier {

  static const List<String> pages = [
    "Blog",
    "Cart",
    "Wishlist"
    "Orders",
  ];

  int _currentPageIndex = 0;
  String _currentPageTitle = "Blog";

  int get currentPageIndex => _currentPageIndex;
  String get currentPageTitle => _currentPageTitle;

  void jogToNextPage() {
    if(_currentPageIndex != 3) {
      _currentPageIndex++;
      _currentPageTitle = pages[_currentPageIndex];
    }
    else {
      _currentPageIndex = 0;
      _currentPageTitle = pages[_currentPageIndex];
    }
    notifyListeners();
  }

  void trekToPreviousPage() {
    if(_currentPageIndex != 0) {
      _currentPageIndex--;
      _currentPageTitle = pages[_currentPageIndex];
    }
    else {
      _currentPageIndex = 3;
      _currentPageTitle = pages[_currentPageIndex];
    }
    notifyListeners();
  }
}