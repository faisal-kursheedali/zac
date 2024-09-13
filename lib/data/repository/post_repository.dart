import 'dart:convert';

import 'package:zac/data/model/Posts.dart';
import 'package:zac/data/network/post_network.dart';

class PostRepository {
  final PostNetwork postNetwork;

  PostRepository({required this.postNetwork});

  Future<Posts> createPost(
      {required String title,
      required String content,
      required String userId}) async {
    try {
      dynamic value = {'title': title, 'content': content};
      String res = await postNetwork.createPost(userId: userId, data: value);
      final data = jsonDecode(res);

      // if (data['cod'] != '200') {
      //   throw "An unexpected Error occered";
      // }

      // temp = data['list'][0]['main']['temp'];
      return Posts.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Posts> updatePost(
      {required String title,
      required String content,
      required String userId,
      required String postId}) async {
    try {
      dynamic value = {"title": title, "content": content};
      String res = await postNetwork.updatePost(
          userId: userId, data: value, postId: postId);
      final data = jsonDecode(res);

      // if (data['cod'] != '200') {
      //   throw "An unexpected Error occered";
      // }

      // temp = data['list'][0]['main']['temp'];
      return Posts.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Posts> likePost(
      {required String userId, required String postId}) async {
    try {
      String res = await postNetwork.likePost(userId: userId, postId: postId);
      final data = jsonDecode(res);

      // if (data['cod'] != '200') {
      //   throw "An unexpected Error occered";
      // }

      // temp = data['list'][0]['main']['temp'];
      return Posts.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Posts> getAllPost() async {
    try {
      String res = await postNetwork.getAllPost();
      final data = jsonDecode(res);

      // if (data['cod'] != '200') {
      //   throw "An unexpected Error occered";
      // }

      // temp = data['list'][0]['main']['temp'];
      return Posts.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
