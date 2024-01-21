// ignore_for_file: public_member_api_docs, sort_constructors_first
class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  @override
  String toString() => 'Post(id: $id, title: $title, body: $body)';
}
