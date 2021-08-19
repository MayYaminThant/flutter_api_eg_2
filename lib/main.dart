import 'package:flutter/material.dart';
import 'package:flutter_api_eg_2/model/comment.dart';
import '../controller/btn_controller.dart';
import 'package:provider/provider.dart';
import '../api/typicode_api.dart';
import '../model/post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ButtonController(ButtonName.POST.toString())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Post>> getPostData() async {
    List<Post> list = await PostUrl().getPost();
    return list;
  }

  Future<List<Comment>> getCommentData() async {
    List<Comment> commentLst = await CommentUrl().getComment();
    return commentLst;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Demo'),
      ),
      body: Consumer<ButtonController>(
        builder: (context, controller, widget) {
          return FutureBuilder<List>(
            future: controller.btnName == ButtonName.POST.toString()
                ? getPostData()
                : getCommentData(),
            builder: (BuildContext buildContext, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return successBody(context, snapshot, controller);
              } else if (snapshot.hasError) {
                return const Text('Error');
              }
              return const Text('Empty data');
            },
          );
        },
      ),
    );
  }

  Widget successBody(BuildContext context, AsyncSnapshot<List> snapshot,
      ButtonController controller) {
    double width = MediaQuery.of(context).size.width - 10;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: width,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.grey,
                  ),
                ),
                child: Text(
                  snapshot.data!.length.toString() + ' ' + controller.btnName,
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.black),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    controller.btnName = ButtonName.POST.toString();
                  },
                  child: Text('Post Length')),
              ElevatedButton(
                  onPressed: () {
                    controller.btnName = ButtonName.COMMENT.toString();
                  },
                  child: Text('Comment Length')),
            ],
          )
        ],
      ),
    );
  }
}
