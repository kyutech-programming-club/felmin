import 'package:flutter/material.dart';
import 'diary.dart';
import 'image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Felemin',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  String dateText;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Felmin'),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.account_circle,),),
              Tab(icon: Icon(Icons.search,),),
              Tab(icon: Icon(Icons.lightbulb_outline,),),
              Tab(icon: Icon(Icons.calendar_today),),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: new MyImage(imagePath: "assets/yumekawa_animal_neko.png"),
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        child: FloatingActionButton(
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              //child: new TalkArea(),
            ),
            Container(
              color: Colors.white,
            ),
            Container(
              color: Colors.white,
              child: new Diary(),
            ),
          ],
        ),
      ),
    );
  }
}
