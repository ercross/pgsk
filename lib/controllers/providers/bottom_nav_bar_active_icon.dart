import 'package:flutter/cupertino.dart';

class BottomNavBarActiveIcon with ChangeNotifier {
  int _value = 0;

  int get value => _value;

  void changeValue(int newValue) {
    if (newValue > 4) {/*do nothing*/}
    _value = newValue;
    notifyListeners();
  }
}