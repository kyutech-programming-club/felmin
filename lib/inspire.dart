import 'package:flutter/material.dart';
import 'twitter.dart';

class Inspire extends StatefulWidget {

  String keyWord;
  var searchWords = new List();

  Inspire({this.keyWord,this.searchWords}): super();

  @override
  _Inspire createState() => _Inspire();
}

class _Inspire extends State<Inspire> {

  void changeKeyWord(){
    setState(() {
      widget.keyWord = (widget.searchWords..shuffle()).first.toString();
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
