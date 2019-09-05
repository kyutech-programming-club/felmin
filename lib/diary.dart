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
      body: Center(
        child: new Display(Collection: 'answers',Field: 'text',),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {

        }),
        tooltip: 'tap',
        child: Icon(Icons.send),
      ),
    );
  }
}