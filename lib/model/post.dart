import 'dart:convert';

List<Post> postStrFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

class Post {
  Post({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
      );
}
