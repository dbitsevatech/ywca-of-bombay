import 'package:flutter/material.dart';

import 'constants.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final double screenHeight;
  final String route;
  final Function onPressedFunction;

  GradientButton({
    @required this.buttonText,
    @required this.screenHeight,
    this.route,
    this.onPressedFunction,
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
          ],
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextButton(
        child: Center(
          child: Text(
            buttonText,
            // 'LET\'S GO',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: () {
          // Navigator.of(context).pushReplacementNamed(route);
          onPressedFunction();
        },
      ),
    );
  }
}
