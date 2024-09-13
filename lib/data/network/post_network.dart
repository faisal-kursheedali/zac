import 'dart:convert';

import 'package:http/http.dart' as http;

class PostNetwork {
  String url = "https://zac-mauve.vercel.app";
  // String url = "http://localhost:3000";

  Future<String> createPost({required data, required String userId}) async {
    try {
      final res = await http.post(Uri.parse('$url/api/createPost'),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"userId": userId, "data": data}));
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

  Future<String> updatePost(
      {required data, required String userId, required String postId}) async {
    try {
      final res = await http.post(Uri.parse('$url/api/updatePost'),
          headers: {"Content-Type": "application/json"},
          body:
              json.encode({"userId": userId, "data": data, "postId": postId}));
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

  Future<String> likePost(
      {required String userId, required String postId}) async {
    try {
      final res = await http.post(Uri.parse('$url/api/likePost'),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"userId": userId, "postId": postId}));
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

  Future<String> getAllPost() async {
    try {
      final res = await http.get(
        Uri.parse('$url/api/getAllPosts'),
        // headers: {"Content-Type": "application/json"},
        // body: json.encode({"userId": userId, "postId": postId})
      );
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
