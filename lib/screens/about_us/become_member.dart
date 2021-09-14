import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../contact_us/contact_us.dart';
import '../../widgets/constants.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/blue_bubble_design.dart';
import '../events/user_events.dart';

class BecomeMemberScreen extends StatefulWidget {
  @override
  _BecomeMemberScreenState createState() => _BecomeMemberScreenState();
}

class _BecomeMemberScreenState extends State<BecomeMemberScreen> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),

      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    // margin: EdgeInsets.all(0.0),
                    // child: CustomPaint(
                    //   painter: BlueBubbleDesign(),
                    // ),
                    child: DetailPageBlueBubbleDesign(),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                  top: _height * 0.05,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/about_us/membership.png',
                      width: 400,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: _height * 0.05,
                    ),
                    Text(
                      'Join the YWCA Family today!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'RacingSansOne',
                        color: secondaryColor,
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    Text(
                      'A prospective member has to attend minimum two meetings (either area meetings or YWCA programme/event).'
                      ' She then fills the membership form which is signed by the Area Chairperson. \n\n This is forwarded to the Membership Committee.'
                      ' The Membership Committee then recommends it to the board and then the membership is approved by the board.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Montserrat',
                        height: 1.25,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            text: "For more details, visit:  ",
                          ),
                          TextSpan(
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            text: "Contact Us\n",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                // ContactUs();
                                print("contact us pressed");
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    // builder: (context) => MainWidget(),
                                    builder: (context) => ContactUs(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    GradientButton(
                      buttonText: "Return to Events",
                      screenHeight: _height,
                      onPressedFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // builder: (context) => MainWidget(),
                            builder: (context) => Events(),
                          ),
                        );
                        // Navigator.pop(context);
                      },
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
