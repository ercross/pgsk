import 'package:flutter/cupertino.dart';

class BottomNavBarActiveIcon with ChangeNotifier {
  int _value = 0;

  ///value is the index of the icon currently hightlighted
  /// 0 = homepage, 1 = CategoryPage, 2 = ExplorePage, 3 = SearchPage, 4 = AccountPage
  int get value => _value;

  void changeValue(int newValue) {
    if (newValue > 4) {/*do nothing*/}
    _value = newValue;
    notifyListeners();
  }
}