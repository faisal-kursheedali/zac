import 'package:flutter/material.dart';
import 'package:zac/data/model/user.dart';
import 'package:zac/data/repository/user_repository.dart';
import 'package:zac/data/sp.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository userRepository;
  UserProvider({required this.userRepository});
  User? userDate;
  String? error;
  bool isLoading = false;

  void getUserData(BuildContext context, {required String userId}) async {
    try {
      isLoading = true;
      notifyListeners();
      final User res = await userRepository.getUserData(userId: userId);
      userDate = res;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      _showSnackBar(context, error!);
      notifyListeners();
    }
  }

  Future<bool> loginUser(BuildContext context,
      {required String email, required String password}) async {
    try {
      isLoading = true;
      notifyListeners();
      final User res =
          await userRepository.loginUser(email: email, password: password);
      userDate = res;
      isLoading = false;
      SP.setUserIdToSP(userDate!.data.id);
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      isLoading = false;
      _showSnackBar(context, error!);
      notifyListeners();
      return false;
    }
  }

  Future<bool> signupUser(BuildContext context,
      {required String name,
      required String email,
      required String password}) async {
    try {
      isLoading = true;
      notifyListeners();
      final User res = await userRepository.signupUser(
          name: name, email: email, password: password);
      userDate = res;
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      isLoading = false;
      _showSnackBar(context, error!);
      notifyListeners();
      return false;
    }
  }

  void logoutUser() {
    userDate = null;
    notifyListeners();
  }
}

void _showSnackBar(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
