import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:felmin/search/inspire.dart';
//import 'synonym.dart';

class initialInspire extends StatefulWidget {
  @override
  _initialInspire createState() => new _initialInspire();
}

class _initialInspire extends State<initialInspire> {

  var keyWords = new List();
  //var synonyms = new List();
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return keyWords.length == 0 ?
    StreamBuilder(
      stream: Firestore.instance.collection('synonyms').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // エラーの場合
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // 通信中の場合
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            return ListView(
              children: snapshot.data.documents.map((
                  DocumentSnapshot document) {
                keyWords.add(document['synonym']);
                return new ListTile(
                  title: this.flag ? createInitState() : null,
                );
              }).toList(),
            );
        }
      },
    ) :
    Inspire(keyWord:(keyWords..shuffle()).first.toString(), searchWords: keyWords,);
  }

  createInitState() {
    this.flag = false;
    return Column(
        children: <Widget>[
          Container(height: 150.0,),
          Container(
            child: Text(
              "繰り返しの日常から一歩踏み出そう!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          RaisedButton(
            child: Text("Search"),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            onPressed: () {
              setState(() {});
            },
          ),
        ]
    );
  }
}