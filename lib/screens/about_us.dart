import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../widgets/blue_bubble_design.dart';
import '../widgets/constants.dart';
import '../widgets/gradient_button.dart';

// ignore: must_be_immutable, camel_case_types
class AboutUs extends KFDrawerContent {
  @override
  _AboutUsState createState() => _AboutUsState();
}

// ignore: camel_case_types
class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                MainPageBlueBubbleDesign(),
                Positioned(
                  child: AppBar(
                    centerTitle: true,
                    title: Text(
                      "YWCA Of Bombay",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18.0,
                        color: Colors.black87,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: widget.onMenuPressed,
                    ),
                  ),
                ),
                // Events & Search bar Starts
                Positioned(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: _height * 0.095),
                      child: Text(
                        'OUR STORY',
                        style: TextStyle(
                          fontSize: 35,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RacingSansOne',
                          letterSpacing: 2.5,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 3.0),
                              blurRadius: 3.0,
                              color: Color(0xff333333),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      Text(
                        'The young women\'s Christian association (YWCA) was established in 1855, '
                            'when the movement formed on prayer and service united together and adopted'
                            'the blue triangle as its symbol. The blue triangle signifies the unity and '
                            'completeness of body, mind and spirit.\n',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.25,
                          color: Colors.black87,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        'The history of YWCA dates back to 1875 when the first local association was'
                            'established in Mumbai. This was followed by the YWCA of India in the year'
                            '1896. It is one of the oldest non-profit community service organizations for women'
                            'In India, which is based on the biblical principle \"love thy neighbour as thyself\".\n',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.25,
                          color: Colors.black87,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        'The YWCA of Bombay is registered under the societies registration act, 1860 under no. 44 dated'
                            '06-08-1952 and of the Bombay public trust act, 1950 under no. F/388 (BOM.) Dated 13-07-1953.',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: Colors.black87,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      // ),
                      SizedBox(
                        height: _height * 0.025,
                      ),
                      GradientButton(
                        buttonText: 'Become a member today!',
                        screenHeight: _height,
                        route: 'register2',
                        onPressedFunction: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "To know more.",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              color: Colors.black54,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => LoginScreen()),
                              //     (route) => false);
                            },
                            child: Text(
                              ' Visit Here',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Color(0xff49DEE8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: _height * 0.01),
                    ],
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: <Widget>[
            //           Container(
            //             margin: EdgeInsets.all(10),
            //             height: 200.0,
            //             child: SizedBox.fromSize(
            //               size: Size(200, 200),
            //               child: ClipOval(
            //                 child: Material(
            //                   color: Color.fromRGBO(0, 210, 225, 1),
            //                   child: InkWell(
            //                     splashColor: Color.fromRGBO(0, 250, 225, 1),
            //                     onTap: () {},
            //                     child: Center(
            //                         child: Text(
            //                       'OUR STORY!',
            //                       style: TextStyle(
            //                         shadows: [
            //                           Shadow(
            //                             blurRadius: 10.0,
            //                             color: Colors.black,
            //                             offset: Offset(5.0, 5.0),
            //                           ),
            //                         ],
            //                         fontSize: 31,
            //                         fontFamily: 'Lily Scipt One',
            //                         fontWeight: FontWeight.bold,
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //       ),
            //           Container(
            //         margin: EdgeInsets.all(0),
            //         height: 30.0,
            //         child: Text(
            //           'YWCA OF BOMBAY',
            //           style: TextStyle(
            //             fontSize: 25,
            //             fontFamily: 'Lily Script One',
            //             fontWeight: FontWeight.bold,
            //             color: Colors.lightBlueAccent,
            //           ),
            //         ),
            //       ),
            //           Container(
            //           margin: EdgeInsets.all(0),
            //           height: 30.0,
            //           child: Text(
            //             'EMPOWERING WOMEN',
            //             style: TextStyle(
            //               fontSize: 25,
            //               fontFamily: 'Lily Script One',
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black87,
            //             ),
            //           ),
            //         ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
