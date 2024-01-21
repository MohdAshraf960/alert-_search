import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_demo/post_model.dart';
import 'package:test_demo/posts_service.dart';

class PostNotifier extends BaseNotifier {
  TextEditingController textEditingController = TextEditingController();
  List<Post> postsList = [];

  final PostService _postService = PostService();

  FutureOr<void> getPostsLists(String query) async {
    try {
      setState(DataState.loading);
      postsList.clear();
      postsList = await _postService.searchPosts(query);
      if (postsList.isNotEmpty) {
        setState(DataState.success);
      } else {
        setState(DataState.empty);
      }
    } catch (e) {
      setState(DataState.error);
      debugPrint(e.toString());
    }
  }
}

final postNotifierProvider = AutoDisposeChangeNotifierProvider<PostNotifier>(
  (_) => PostNotifier(),
);

enum DataState { init, loading, success, error, submitting, empty }

abstract class BaseNotifier extends ChangeNotifier {
  DataState dataState;
  BaseNotifier({this.dataState = DataState.init});

  void setState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void init() {}
}
