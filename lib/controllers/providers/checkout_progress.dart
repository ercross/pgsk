import 'package:flutter/cupertino.dart';

class CheckoutProgress with ChangeNotifier {
  int _index = 0;

  int get index => _index;

  ///saveProgress increments progress value and allows display of the next tab
  void saveProgress() {
    _index++;
    notifyListeners();
  }

  ///revertChanges decrements progress value and allows display of the previous tab
  void revertChanges() {
    _index--;
    notifyListeners();
  }
}
