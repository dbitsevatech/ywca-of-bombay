import 'package:flutter/material.dart';

import 'constants.dart';

class MainPageBlueBubbleDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: MainPageBlueBubblePainter(),
      ),
    );
  }
}

// for scaffold without appbar property
class DetailPageBlueBubbleDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: DetailPageBlueBubblePainter(),
      ),
    );
  }
}

// Painter for MainPageBlueBubbleDesign Widget
class MainPageBlueBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = primaryColor.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // main page circles
    canvas.drawCircle(Offset(-5, 60), 100, paint1); // top circle
    canvas.drawCircle(Offset(100, -5), 100, paint1); // left circle
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// Painter for DetailPageBlueBubbleDesign Widget
class DetailPageBlueBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = primaryColor.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // detail page circle
    canvas.drawCircle(Offset(-5, 15), 100, paint1); // top circle
    canvas.drawCircle(Offset(100, -50), 100, paint1); // left circle
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
