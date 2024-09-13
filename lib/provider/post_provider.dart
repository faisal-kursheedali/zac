import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zac/data/model/Posts.dart';
import 'package:zac/data/repository/post_repository.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository postRepository;
  PostProvider({required this.postRepository});
  Posts? posts;
  String? error;
  bool isLoading = false;

  Future<bool> createPost(BuildContext context,
      {required String userId,
      required String title,
      required String content}) async {
    try {
      isLoading = true;
      notifyListeners();
      final Posts res = await postRepository.createPost(
          userId: userId, title: title, content: content);
      posts = res;
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

  Future<bool> updatePost(BuildContext context,
      {required String userId,
      required String postId,
      required String title,
      required String content}) async {
    try {
      isLoading = true;
      notifyListeners();
      final Posts res = await postRepository.updatePost(
          userId: userId, title: title, content: content, postId: postId);
      posts = res;
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

  void likePost({
    required String userId,
    required String postId,
  }) async {
    try {
      // isLoading = true;
      notifyListeners();
      final Posts res =
          await postRepository.likePost(userId: userId, postId: postId);
      posts = res;
      // isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      // isLoading = false;
      // _showSnackBar(context, error!);
      notifyListeners();
    }
  }

  void getAllPost(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      final Posts res = await postRepository.getAllPost();
      posts = res;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      _showSnackBar(context, error!);
      notifyListeners();
    }
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
