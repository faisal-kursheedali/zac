import 'dart:convert';

import 'package:http/http.dart' as http;

class UserNetwork {
  String url = "https://zac-mauve.vercel.app";
  // String url = "http://localhost:3000";

  Future<String> getUserData({required String userId}) async {
    try {
      final res = await http.post(Uri.parse('$url/api/getUserData'),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"userId": userId}));
      if (res.statusCode != 200) {
        final data = jsonDecode(res.body);
        throw data;
      }
      return res.body;
    } catch (e) {
      if ((e is Map<String, dynamic>) && e['msg'] != null) {
        throw e['msg'];
      } else {
        throw e.toString();
      }
    }
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    try {
      final res = await http.post(Uri.parse('$url/api/loginUser'),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"email": email, "password": password}));

      if (res.statusCode != 200) {
        final data = jsonDecode(res.body);
        throw data;
      }
      return res.body;
    } catch (e) {
      if ((e is Map<String, dynamic>) && e['msg'] != null) {
        throw e['msg'];
      } else {
        throw e.toString();
      }
    }
  }

  Future<String> signupUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final res = await http.post(Uri.parse('$url/api/createUser'),
          headers: {"Content-Type": "application/json"},
          body: json
              .encode({"name": name, "email": email, "password": password}));
      if (res.statusCode != 200) {
        final data = jsonDecode(res.body);
        throw data;
      }
      return res.body;
    } catch (e) {
      if ((e is Map<String, dynamic>) && e['msg'] != null) {
        throw e['msg'];
      } else {
        throw e.toString();
      }
    }
  }
}
