import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';

class FlareImage extends StatefulWidget {

  final FlareControls animationController;

  FlareImage({this.animationController}): super();

  @override
  _FlareImage createState() => _FlareImage();
}

class _FlareImage extends State<FlareImage> {
  @override
  Widget build(BuildContext context) {
    return FlareActor(
      "assets/plants_logo.flr",
      alignment:Alignment.center,
      animation: "start",
      fit: BoxFit.contain,
      controller: widget.animationController,
    );
  }
}

