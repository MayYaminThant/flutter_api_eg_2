import 'dart:convert';

List<Comment> commentStrFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

class Comment {
  Comment({
    required this.id,
    required this.body,
    required this.postId,
  });

  int id;
  String body;
  int postId;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        body: json["body"],
        postId: json["postId"],
      );
}
