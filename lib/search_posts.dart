import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_demo/posts_notifier.dart';

class Search extends ConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.read(postNotifierProvider);
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.40,
        padding: const EdgeInsets.all(16.0),
        child: StatefulBuilder(
          builder: (context, setState) => Column(
            children: [
              TextField(
                controller: posts.textEditingController,
                decoration: const InputDecoration(hintText: "Search"),
                onChanged: (value) {
                  _debouncedSearch(value, posts);
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: posts.isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : posts.noDataFound
                        ? const Center(
                            child: Text("No posts found!!!"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: posts.postsList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  posts.postsList[index].title,
                                ),
                                onTap: () {
                                  Navigator.pop(
                                      context, posts.postsList[index]);
                                },
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _debouncedSearch(String query, PostNotifier posts) {
    Future.delayed(const Duration(milliseconds: 500), () async {
      await posts.getPostsLists(query);
    });
  }
}
