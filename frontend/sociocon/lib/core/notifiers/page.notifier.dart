import 'package:flutter/material.dart';

class PageNotifier extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selctedIndex => _selectedIndex;

  void setSelectedIndex({
    required int value,
  }) {
    _selectedIndex = value;
    notifyListeners();
  }
}
