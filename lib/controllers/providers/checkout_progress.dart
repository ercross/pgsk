import 'package:flutter/cupertino.dart';

class CheckoutProgress with ChangeNotifier {
  int _value = 0;

  int get value => _value;

  ///saveProgress increments progress value and allows display of the next tab
  void saveProgress () {
    _value++;
    notifyListeners();
  }

  ///revertChanges decrements progress value and allows display of the previous tab
  void revertChanges() {
    _value--;
    notifyListeners();
  }
}