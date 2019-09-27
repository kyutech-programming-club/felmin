import 'package:flutter/material.dart';
import 'twitter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Inspire extends StatefulWidget {

  String keyWord;
  var searchWords = new List();

  Inspire({this.keyWord,this.searchWords}): super();

  @override
  _Inspire createState() => _Inspire();
}

class _Inspire extends State<Inspire> {

  final myController = TextEditingController();

  @override
  void dispose() {
    // ウィジェットの破棄時にコントローラーも破棄する
    myController.dispose();
    super.dispose();
  }

  void changeKeyWord(){
    setState(() {
      widget.keyWord = (widget.searchWords..shuffle()).first.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
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
            Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: TextField(
                    controller: myController,
                    decoration: InputDecoration(
                        hintText: '入力してください'
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child:  FloatingActionButton(
                    onPressed: () {
                      Firestore.instance
                               .collection('ToDoList')
                               .document(myController.text)
                               .setData({
                                 'checked' : false,
                                  'text' :  myController.text,
                               });
                      setState(() {
                        myController.clear();
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    },
                    tooltip: 'tap',
                    child: Icon(Icons.send),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}