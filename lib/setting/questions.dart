import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'synonym.dart';

class Questions extends StatefulWidget {
  @override
  _Questions createState() => _Questions();
}

class _Questions extends State<Questions> {
  final myController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  List<String> keywords;
  bool flag = true;
//  @override
//  void dispose() {
//    // ウィジェットの破棄時にコントローラーも破棄する
//    myController[0].dispose();
//    myController[1].dispose();
//    myController[2].dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return flag ?
    Column(
      children: <Widget>[
        StreamBuilder(
          stream: Firestore.instance
              .collection("KeyWords")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // エラーの場合
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            // 通信中の場合
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('');
              default:
                return createListView(context, snapshot);
            }
          },
        ),
        FloatingActionButton(
          onPressed: (){
            for(var i = 0;i < myController.length;i++){
              if(myController[i].text == "") continue;
              Firestore.instance
                  .collection("KeyWords")
                  .document((i + 1).toString())
                  .updateData({"KeyWord": myController[i].text});
              keywords[i] = myController[i].text;
              myController[i].clear();
            }
            setState(() {flag = false;});
          },
          tooltip: 'tap',
          child: Icon(Icons.update),
        ),
      ],
    ) :
    synonymBuilder(context, keywords);
  }

  Widget createListView(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<DocumentSnapshot> values = snapshot.data.documents;
    keywords = List<String>();
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        keywords.add(values[index]["KeyWord"]);
        return TextField(
          controller: myController[index],
          autocorrect: false, // 入力し過ぎるとバグが起きるみたい。その対策。
          decoration: InputDecoration(
            labelText: values.asMap()[index]['question'], // asMap()とは
            hintText: values.asMap()[index]["KeyWord"],
          ),
        );
      },
    );
  }

  Widget synonymBuilder(BuildContext context,List<String> keywords) {
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: keywords.length,
      itemBuilder: (BuildContext context, int index) {
        return new Synonym(
          documentId: (index + 1).toString(),
          keyword: keywords[index],
        );
      },
    );
  }
}