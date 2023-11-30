import 'package:flutter/material.dart';

class TabManager extends ChangeNotifier {
  int selectedTab = 0;
  bool isNewUser = false;

  void setNewUserStatus(bool isNew) {
    isNewUser = isNew;
    notifyListeners();
  }

  void goToTab(index) {
    selectedTab = index;
    notifyListeners();
  }

  void goToRecipes() {
    selectedTab = 1;
    notifyListeners();
  }
}
