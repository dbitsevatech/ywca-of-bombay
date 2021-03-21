import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

// ignore: must_be_immutable
class Initiatives extends KFDrawerContent {
  @override
  _InitiativesState createState() => _InitiativesState();
}

class _InitiativesState extends State<Initiatives> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            Stack(
              // circle design
              children: <Widget>[
                Positioned(
                  child: Image.asset("assets/images/circle-design.png"),
                ),
                Positioned(
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        child: Material(
                          shadowColor: Colors.transparent,
                          color: Colors.transparent,
                          child: IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.black,
                            ),
                            onPressed: widget.onMenuPressed,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(width: 15)
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Initiatives'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
