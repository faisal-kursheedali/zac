import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String? userId;

  void loginUser(String? user) {
    userId = user;
    notifyListeners();
  }

  void logoutUser() {
    userId = null;
    notifyListeners();
  }
}
