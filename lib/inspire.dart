import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oauth/oauth.dart'as oauth;
import 'key.dart';

Future<Post> fetchPost(String keyWord) async {
  oauth.Tokens oauthTokens = new oauth.Tokens(
      consumerId: CONSUMERID,
      consumerKey: CONSUMERKEY,
      userId: USERID,
      userKey: USERKEY);

  var streamClient = new oauth.Client(oauthTokens);
  var uri = Uri.parse("https://api.twitter.com/1.1/search/tweets.json?q=$keyWord&result_type=mixed&count=50");
  var request = new http.Request("GET", uri);

  var response = await streamClient.send(request);

  if (response.statusCode == 200) {
    Map resJson = json.decode(await response.stream.bytesToString());

    print(resJson);
    return Post.fromJson(resJson);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final List<dynamic> tweet;

  Post({this.tweet});

  factory Post.fromJson(Map<String, dynamic> json) {

    return Post(
      tweet: json['statuses'],
    );
  }
}

class Twitter extends StatelessWidget {
  final Future<Post> post;
  final String keyWord;

  Twitter({Key key, this.post, this.keyWord}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder<Post>(
        future: fetchPost(this.keyWord),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return createListView(context, snapshot);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      );
  }


  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<dynamic> values = snapshot.data.tweet;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
            child:  Container(
              height: 300,
              child: Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text(values[index]['user']['name']),
                    subtitle: new Text(values[index]['created_at']),
                  ),
                  Text(values[index]['text']),
                ],
              ),
            )
        );
      },
    );
  }

}

class Inspire extends StatefulWidget {

  String keyWord;

  Inspire({this.keyWord}): super();

  @override
  _Inspire createState() => _Inspire();
}

class _Inspire extends State<Inspire> {

  void changeKeyWord(){
    setState(() {
      widget.keyWord = "プロ研";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  height: 30,
                  child: Text(widget.keyWord+"で検索した結果"),
                ),
              ),
              Expanded(
                flex: 1,
                child: FloatingActionButton(
                  onPressed: changeKeyWord,
                  tooltip: 'tap',
                  child: Icon(Icons.refresh),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 400,
            child: new Twitter(
                post: fetchPost(widget.keyWord), keyWord: widget.keyWord),
          ),
        ],
      ),
    );
  }
}
