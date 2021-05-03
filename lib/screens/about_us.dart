import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:ywcaofbombay/widgets/gradient_button.dart';

import '../widgets/blue_bubble_design.dart';
import '../widgets/constants.dart';

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
                        fontFamily: 'LilyScriptOne',
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
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: _height * 0.06,
                    ),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Center(
                            child: Text(
                              'THE YOUNG WOMEN\'S CHRISTIAN ASSOCIATION (YWCA) WAS ESTABLISHED IN 1855, '
                                  'WHEN THE MOVEMENT FORMED ON PRAYER AND SERVICE UNITED TOGETHER AND ADOPTED'
                                  'THE BLUE TRIANGLE AS ITS SYMBOL. THE BLUE TRIANGLE SIGNIFIES THE UNITY AND '
                                  'COMPLETENESS OF BODY, MIND AND SPIRIT.\n',
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.25,
                                color: Colors.black87,
                                fontFamily: 'Montserrat',
                              ),
                            )
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Center(
                            child: Text(
                              'THE HISTORY OF YWCA DATES BACK TO 1875 WHEN THE FIRST LOCAL ASSOCIATION WAS'
                                  'ESTABLISHED IN MUMBAI. THIS WAS FOLLOWED BY THE YWCA OF INDIA IN THE YEAR'
                                  '1896. IT IS ONE OF THE OLDEST NON-PROFIT COMMUNITY SERVICE ORGANIZATIONS FOR WOMEN'
                                  'IN INDIA, WHICH IS BASED ON THE BIBLICAL PRINCIPLE \"LOVE THY NEIGHBOR AS THYSELF\".\n',
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.25,
                                color: Colors.black87,
                                fontFamily: 'Montserrat',

                              ),
                            )
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Center(
                            child: Text(
                              'THE YWCA OF BOMBAY IS REGISTERED UNDER THE SOCIETIES REGISTRATION ACT, 1860 UNDER NO. 44 DATED'
                                  '06-08-1952 AND OF THE BOMBAY PUBLIC TRUST ACT, 1950 UNDER NO. F/388 (BOM.) DATED 13-07-1953.',
                              style: TextStyle(
                                fontSize: 15,
                                height:1.5,
                                color: Colors.black87,
                                fontFamily: 'Montserrat',

                              ),
                            )
                        ),
                      ),
                    ),

                    SizedBox(
                      height: _height * 0.05,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: GradientButton(
                        buttonText: 'Become a member today!',
                        screenHeight: _height,
                        route: 'register2',
                        onPressedFunction: () {
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text("To know more.",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black54,
                                  ),),
                            ),
                            Center(
                                child: Text(
                                  ' Visit Here',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff49DEE8),
                                  ),
                                ),),
                          ],
                        ),)
                  ],
                ),
              )
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
