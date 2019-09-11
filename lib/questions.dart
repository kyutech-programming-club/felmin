import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Questions extends StatelessWidget {
  final myController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

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
    return Column(
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
              myController[i].clear();
            }
            Navigator.pushNamed(context, '/second-set');
          },
          tooltip: 'tap',
          child: Icon(Icons.update),
        ),
      ],
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<DocumentSnapshot> values = snapshot.data.documents;
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return TextField(
          controller: myController[index],
          autocorrect: false, // 入力し過ぎるとバグが起きるみたい。その対策。
          decoration: InputDecoration(
            labelText: values.asMap()[index]['question'],
            hintText: values.asMap()[index]["KeyWord"],
          ),
        );
      },
    );
  }
}