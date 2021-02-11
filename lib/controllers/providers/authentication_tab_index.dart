import 'package:flutter/cupertino.dart';

class AuthenticationTabIndex with ChangeNotifier {

  ///indexTab is the current tab displayed on the AuthenticationPage
  ///values can only be either 0 or 1
  int value = 0;

  void changeIndex(int newValue) {
    if (!(newValue > 1) || !(newValue < 0)) value = newValue;
    print("Help me ooo. Dem don dey finger me");
    notifyListeners();
  }
}