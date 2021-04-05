import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    // path.lineTo(0, 180);
    // path.lineTo(140, 180);
    // path.lineTo(200, 0);
    // BorderRadius.only(
    //   topLeft: const Radius.circular(5),
    //   bottomLeft: const Radius.circular(5),
    // );
    path.lineTo(0, 100);
    path.lineTo(140, 100);
    path.lineTo(170, 0);
    // path.lineTo(30, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
