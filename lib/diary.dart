import 'package:flutter/material.dart';
import 'firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Diary extends StatefulWidget {
  @override
  _Diary createState() => _Diary();
}

class _Diary extends State<Diary> {
  final myController = TextEditingController();
  String dateText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            child: new Display(Collection: 'answers',Field: 'text',),
          ),
          TextField(
            controller: myController,
            decoration: InputDecoration(
                hintText: '入力してください'
            ),
          ),
      ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          dateText = DateTime.now().toString();
          Firestore.instance.collection('answers').add({
            'text': '${myController.text}',
            'timestamp': dateText,
          });
          myController.clear();
        }),
        tooltip: 'tap',
        child: Icon(Icons.send),
      ),
    );
  }
}