import 'package:flutter/material.dart';
import 'questions.dart';
import 'synonym.dart';


class Setting extends StatefulWidget {
  @override
  _Setting createState() => new _Setting();
}

class _Setting extends State<Setting> {

//  var str = ["ラーメン","うどん","サッカー"];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Questions(),
      routes: <String, WidgetBuilder> {
        '/first-set': (BuildContext context) => new Questions(),
        '/second-set': (BuildContext context) => Synonym(post: fetchSuggestionPost()),
      },
    );
  }
//    return Container(
//      child: Column(
//        children: <Widget>[
//          TextField(
//            controller: myController[0],
//            autocorrect: false, // 入力し過ぎるとバグが起きるみたい。その対策。
//            decoration: InputDecoration(
//              labelText: '好きな食べ物教えんかい', // どうせ後で、質問かえるけんね
//              hintText: str[0],
//            ),
//          ),
//          TextField(
//            controller: myController[1],
//            autocorrect: false,
//            decoration: InputDecoration(
//              labelText: '好きな人も教えんかい',
//              hintText: str[1],
//            ),
//          ),
//          TextField(
//            controller: myController[2],
//            autocorrect: false,
//            decoration: InputDecoration(
//              labelText: 'サッカーって打たんかい',
//              hintText: str[2],
//            ),
//          ),
////          Container(child: ,),
//          FloatingActionButton(
//            onPressed: (){
//              setState(() {
//                str[0] = myController[0].text;
//                str[1] = myController[1].text;
//                str[2] = myController[2].text;
//              });
//            },
//            tooltip: 'tap',
//            child: Icon(Icons.update),
//            ),
//        ],
//      ),
//    );
//  }
}