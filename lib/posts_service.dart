import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_demo/post_model.dart';

class PostService {
  Future<List<Post>> searchPosts(String query) async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts?q=$query'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (error) {
      rethrow;
    }
  }
}
