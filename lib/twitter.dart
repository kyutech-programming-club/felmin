import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oauth/oauth.dart'as oauth;
import 'key.dart';

Future<Post> fetchPost() async {
  oauth.Tokens oauthTokens = new oauth.Tokens(
      consumerId: CONSUMERID,
      consumerKey: CONSUMERKEY,
      userId: USERID,
      userKey: USERKEY);

  var streamClient = new oauth.Client(oauthTokens);
  var uri = Uri.parse("https://api.twitter.com/1.1/search/tweets.json?q=サッカー&result_type=recent&count=50");
  var request = new http.Request("GET", uri);

  var response = await streamClient.send(request);

  if (response.statusCode == 200) {
    Map resJson = json.decode(await response.stream.bytesToString());
    //print(i);
    //print(i);
    print(resJson);
    return Post.fromJson(resJson);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final List<dynamic> text;

  Post({this.text});

  factory Post.fromJson(Map<String, dynamic> json) {

    return Post(
      text: json['statuses'],
    );
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return createListView(context, snapshot);
                //return Text(snapshot.data.text);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<dynamic> values = snapshot.data.text;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
              title: new Text(values[index]['text']),
            ),
            new Divider(height: 2.0,),
          ],
        );
      },
    );
  }

}