import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<SuggestionPost> fetchSuggestionPost() async {
  final response = await http.get('https://ruigigo-api.herokuapp.com/?word=サッカー');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return SuggestionPost.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

class SuggestionPost {
  final List<dynamic> res;


  SuggestionPost({this.res});

  factory SuggestionPost.fromJson(List<dynamic> json) {
    return SuggestionPost(
    res: json
    );
  }
}

void main() => runApp(MyApp(post: fetchSuggestionPost()));

class MyApp extends StatelessWidget {
  final Future<SuggestionPost> post;

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
          child: FutureBuilder<SuggestionPost>(
            future: fetchSuggestionPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return createListView(context, snapshot);
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
    List<dynamic> values = snapshot.data.res;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Card(
            child:  Container(
              child: Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text(values[index][0]),
                    //subtitle: new Text(values[index][1].toString()),
                  ),
                  Text(values[index][1].toString()),
                ],
              ),
            )
        );
      },
    );
  }
}

