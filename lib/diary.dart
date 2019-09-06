import 'package:flutter/material.dart';
import 'firebase.dart';


class Diary extends StatefulWidget {
  @override
  _Diary createState() => _Diary();
}

class _Diary extends State<Diary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 300.0,
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            child: new Display(Collection: 'answers',Field: 'text',),
          ),
        ],
      ),
    );
  }
}