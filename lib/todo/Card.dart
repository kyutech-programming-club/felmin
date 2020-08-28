import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('ToDoList')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // エラーの場合
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // 通信中の場合
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading ...');
          default:
            return createListView(context, snapshot);
        }
      },
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<DocumentSnapshot> values = snapshot.data.documents;
    values.sort((a,b) => (a['checked'].toString()).compareTo((b['checked'].toString())));
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: values[index]['checked']? Colors.green : Colors.white,
          child:  Row(
          children: <Widget>[
            Expanded(
              flex: 5,
             child: Text(values[index]['text']),
            ),
            Expanded(
              flex: 1,
              child : FlatButton(
                child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.lightBlue),
                ),
                onPressed: () {
                  Firestore.instance
                           .collection("ToDoList")
                           .document(values[index]['text'])
                           .updateData({"checked": !values[index]['checked']});
                },
              ),
            ),
          ],
        )
        );
      },
    );
  }
}