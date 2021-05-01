import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

// ignore: must_be_immutable
class Home extends KFDrawerContent {
  Home({
    Key key,
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          Column(
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
                                size: 30,
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
              // Row(
              //   children: <Widget>[
              //     ClipRRect(
              //       borderRadius: BorderRadius.all(Radius.circular(32.0)),
              //       child: Material(
              //         shadowColor: Colors.transparent,
              //         color: Colors.transparent,
              //         child: IconButton(
              //           icon: Icon(
              //             Icons.menu,
              //             color: Colors.black,
              //           ),
              //           onPressed: widget.onMenuPressed,
              //         ),
              //       ),
              //     ),
              //     Spacer(),
              //     Container(
              //       height: 40,
              //       width: 40,
              //     ),
              //     SizedBox(width: 15)
              //   ],
              // ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Welcome", style: TextStyle(fontSize: 17)),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text("how you doing ? ",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold)),
                    SizedBox(height: 15),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
