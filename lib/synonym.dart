import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';


Future<SuggestionPost> fetchSuggestionPost(String keyword) async {
  final response = await http.get('https://ruigigo-api.herokuapp.com/?word=$keyword');

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

  factory SuggestionPost.fromJson(final List<dynamic> json) {
    return SuggestionPost(
      res: json
    );
  }
}

class Synonym extends StatelessWidget {

  Future<SuggestionPost> post;
  final String documentId;
  final String keyword;
  Synonym({Key key, this.documentId, this.keyword,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return createFutureBuilder(documentId, keyword);
  }

  Widget createFutureBuilder(String documentId, String keyword) {
    return FutureBuilder<SuggestionPost> (
      future: fetchSuggestionPost(keyword),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("類義語は" + snapshot.data.res[0][0]);
          Firestore.instance
                   .collection("synonyms")
                   .document(documentId)
                   .updateData({"synonym": snapshot.data.res[0][0]});
          return documentId == "1" ? Text("保存しました") : Container();
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return Container();
      },
    );
  }
}