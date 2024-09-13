import 'dart:convert';

import 'package:zac/data/model/user.dart';
import 'package:zac/data/network/user_network.dart';

class UserRepository {
  final UserNetwork userNetwork;
  UserRepository({required this.userNetwork});

  Future<User> loginUser(
      {required String email, required String password}) async {
    try {
      String res =
          await userNetwork.loginUser(email: email, password: password);

      final data = jsonDecode(res);

      // if (data['cod'] != '200') {
      //   throw "An unexpected Error occered";
      // }

      // temp = data['list'][0]['main']['temp'];
      return User.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User> getUserData({required String userId}) async {
    try {
      String res = await userNetwork.getUserData(userId: userId);
      final data = jsonDecode(res);

      // if (data['cod'] != '200') {
      //   throw "An unexpected Error occered";
      // }

      // temp = data['list'][0]['main']['temp'];
      return User.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User> signupUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      String res = await userNetwork.signupUser(
          email: email, password: password, name: name);
      final data = jsonDecode(res);

      // if (data['cod'] != '200') {
      //   throw "An unexpected Error occered";
      // }

      // temp = data['list'][0]['main']['temp'];
      return User.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
