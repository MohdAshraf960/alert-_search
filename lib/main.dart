import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_demo/post_model.dart';
import 'package:test_demo/posts_notifier.dart';
import 'package:test_demo/search_posts.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Posts'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Autocomplete(
          //   optionsViewBuilder: (context, onSelected, options) {

          //   },
          //   optionsBuilder: (text) => (["Fruits", "Veggies"]),
          //   displayStringForOption: (option) => "",
          //   fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {

          //   },
          // ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await _showSearchDialog(context);
              },
              child: const Text('Open Search Dialog'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showSearchDialog(BuildContext context) async {
    final posts = ref.watch(postNotifierProvider);

    final result = await showDialog<Post>(
      context: context,
      builder: (BuildContext context) {
        return Search<Post>(
          displayStringForOption: (data) => data.title,
          searchRequest: (query) => posts.getPostsLists(query),
        );
      },
    );

    log("message ==> $result");
  }
}
