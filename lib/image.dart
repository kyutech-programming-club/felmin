import 'package:flutter/material.dart';

class MyImage extends StatefulWidget{
  MyImage({Key key, this.imagePath}) : super(key: key);
  final String imagePath;

  @override
  _MyImageState createState() => new _MyImageState();
}

class _MyImageState extends State<MyImage> {

  @override
  Widget build(BuildContext context) {
    return  Image.asset(widget.imagePath);
  }
}