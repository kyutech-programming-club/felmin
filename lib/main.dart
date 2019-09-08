import 'package:flutter/material.dart';
import 'diary.dart';
import 'talk.dart';
import 'twitter.dart';

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
                child: new Talk(),
            ),
            Container(
              color: Colors.white,
              child: new Twitter(post: fetchPost()),
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
