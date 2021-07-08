import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final double screenHeight;
  final Function onPressedFunction;

  GradientButton({
    required this.buttonText,
    required this.screenHeight,
    required this.onPressedFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        // horizontal: _width * 0.35,
        vertical: screenHeight * 0.015,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            firstButtonGradientColor,
            firstButtonGradientColor,
            secondButtonGradientColor,
            // Colors.grey[300],
            // Colors.grey[300],
            // Colors.grey[300],
          ],
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextButton(
        child: Center(
          child: AutoSizeText(
            buttonText,
            // 'LET\'S GO',
            maxLines: 1,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        onPressed: () {
          onPressedFunction();
        },
      ),
    );
  }
}
