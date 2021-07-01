import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../events/user_events.dart';
import '../../widgets/constants.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/blue_bubble_design.dart';

class BecomeMemberScreen extends StatefulWidget {
  @override
  _BecomeMemberScreenState createState() => _BecomeMemberScreenState();
}

class _BecomeMemberScreenState extends State<BecomeMemberScreen> {

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    // final _width = MediaQuery.of(context).size.width;

    var defaultText = TextStyle(color: Colors.black);
    var linkText = TextStyle(color: Colors.blue);

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: _height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // padding: const EdgeInsets.all(8),
            children: <Widget>[
              // circle design and Appbar
              Stack(
                children: <Widget>[
                  MainPageBlueBubbleDesign(),
                  Positioned(
                    child: AppBar(
                      centerTitle: true,
                      title: Text(
                        "YWCA Of Bombay",
                        style: TextStyle(
                            fontFamily: 'LobsterTwo',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black87,),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
              // TODO: Make the carousel responsive
              // https://pub.dev/packages/introduction_screen
              // https://pub.dev/packages/gooey_carousel
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new  Image.asset('assets/images/about_us/membership.png',
                        width: 400,
                        height: 200,
                        fit:BoxFit.fill ),
                    Text(
                      '\"Join the YWCA family Today\"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'RacingSansOne',
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'A prospective member has to attend minimum two meetings (either area meetings or YWCA program/event).'
                          'She then fill the membership form which is signed by Area Chairperson. This is forwarded to the Membership Committee.'
                          'The Membership Committee recommends it to the board and then the membership is approved by the board.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  style: defaultText,
                                  text: "For more details"
                              ),
                              TextSpan(
                                  style: linkText,
                                  text: "Contact_Us\n",
                                  recognizer: TapGestureRecognizer()..onTap =  () {
                                  }
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                            child: GradientButton(
                              buttonText: "Return to Events",
                              screenHeight: _height,
                              route: 'events',
                              onPressedFunction: () {
                                Navigator. push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Events()),
                                );
                              }
                              ,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}