import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class FlareImage extends StatefulWidget {
  final String animation;

  FlareImage({
    this.animation
  }): super();
  @override
  _FlareImage createState() => _FlareImage();
}

class _FlareImage extends State<FlareImage> {
  @override
  Widget build(BuildContext context) {
    return FlareActor(
      "assets/plants_logo.flr",
      alignment:Alignment.center,
      animation: widget.animation,
      fit: BoxFit.contain,
    );
  }
}

