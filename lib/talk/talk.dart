import 'package:flutter/material.dart';
import 'image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'flare.dart';
import 'package:flare_flutter/flare_controls.dart';

class Talk extends StatefulWidget {
  @override
  _Talk createState() => _Talk();
}

class _Talk extends State<Talk> {
  final myController = TextEditingController();
  String dateText;
  final FlareControls _animationController = FlareControls();

  @override
  void dispose() {
    // ウィジェットの破棄時にコントローラーも破棄する
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              // child: new MyImage(imagePath: "assets/yumekawa_animal_neko.png"),
              child: FlareImage(animationController:_animationController),
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
                      if(myController.text != "") {
                        dateText = DateTime.now().toString();
                        Firestore.instance.collection('answers').add({
                          'text': '${myController.text}',
                          'timestamp': dateText,
                        });
                      }
                      _animationController.play("animation");
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
    );
  }
}
