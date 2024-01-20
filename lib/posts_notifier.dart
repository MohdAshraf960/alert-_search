import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_demo/post_model.dart';
import 'package:test_demo/posts_service.dart';

class PostNotifier extends ChangeNotifier {
  TextEditingController textEditingController = TextEditingController();
  List<Post> postsList = [];
  bool isLoading = false;
  bool noDataFound = false;
  final PostService _postService = PostService();

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  setData(bool value) {
    noDataFound = value;
    notifyListeners();
  }

  FutureOr<void> getPostsLists(String query) async {
    try {
      setLoading(true);
      postsList = await _postService.searchPosts(query);
      if (postsList.isNotEmpty) {
        setData(true);
      }

      setData(false);
      setLoading(false);
    } catch (e) {
      setData(false);
      setLoading(false);
      debugPrint(e.toString());
    }
  }
}

final postNotifierProvider = ChangeNotifierProvider<PostNotifier>(
  (_) => PostNotifier(),
);
