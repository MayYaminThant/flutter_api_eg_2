import 'package:flutter_api_eg_2/model/comment.dart';
import 'package:http/http.dart' as http;
import '../model/post.dart';

var api = 'https://my-json-server.typicode.com/typicode/demo';
var postUrl = api + '/posts';
var commentUrl = api + '/comments';

class PostUrl {
  Future<List<Post>> getPost() async {
    var url = Uri.parse(postUrl);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return postStrFromJson(response.body);
    }
    return <Post>[];
  }
}

class CommentUrl {
  Future<List<Comment>> getComment() async {
    var url = Uri.parse(commentUrl);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return commentStrFromJson(response.body);
    }

    return <Comment>[];
  }
}
