import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Display extends StatefulWidget {
//  final String Collection;
//  final String Field;
//
//  Display({
//    this.Collection,
//    this.Field
//  }): super();

  @override
  _Display createState() => new _Display();
}

class _Display extends State<Display> {
//  final String collection;
//  final String field;
//
//  _Display({
//    this.collection,
//    this.field
//  }): super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: createListView(),
    );
  }
  createListView() {
    return StreamBuilder(
      stream: Firestore.instance.collection('answers').snapshots(),
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
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['text']),
                );
              }).toList(),
            );
        }
      },
    );
  }
}