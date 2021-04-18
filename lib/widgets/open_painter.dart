import 'package:flutter/material.dart';

import 'constants.dart';

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = primaryColor.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    //a circle
    canvas.drawCircle(Offset(-40, -20), 100, paint1);
    canvas.drawCircle(Offset(60, -100), 100, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
