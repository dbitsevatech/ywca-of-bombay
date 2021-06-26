import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/gestures.dart';

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

  var defaultText = TextStyle(color: Colors.black);
  var linkText = TextStyle(color: Colors.blue);

  final imageList = [
    'assets/images/initiatives/img1.jpg',
    'assets/images/initiatives/img2.jpg',
    'assets/images/initiatives/img3.jpg',
    'assets/images/initiatives/img4.jpg',
    'assets/images/initiatives/img5.jpg',
  ];

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
                     mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      Container(
                        height: 300,
                        child: Swiper(
                          autoplay: false,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              // To centralize the children.
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: AssetImage(imageList[index]),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            );
                          },
                          viewportFraction: 0.8,
                          scale: 0.9,
                          pagination: SwiperPagination(
                            //changing the color of the pagination dots and that of
                            //the active dot
                            builder: DotSwiperPaginationBuilder(
                              color: Colors.grey,
                              activeColor: Color(0XFF80DEEA),
                              //  DotsIndicator(
                              // dotsCount: pageLength,
                              // position: currentIndexPage,
                              // dotsCount: pageLength,
                              // decorator: DotsDecorator()
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'The young women\'s Christian association (YWCA) was established in 1855, '
                            'when the movement formed on prayer and service united together and adopted'
                            'the blue triangle as its symbol. The blue triangle signifies the unity and '
                            'completeness of body, mind and spirit.\n',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.25,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        'The history of YWCA dates back to 1875 when the first local association was'
                            'established in Mumbai. This was followed by the YWCA of India in the year'
                            '1896. It is one of the oldest non-profit community service organizations for women'
                            'In India, which is based on the biblical principle \"love thy neighbour as thyself\".\n',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.25,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        'The YWCA of Bombay is registered under the societies registration act, 1860 under no. 44 dated'
                            '06-08-1952 and of the Bombay public trust act, 1950 under no. F/388 (BOM.) Dated 13-07-1953.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
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
                          RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                        style: defaultText,
                                        text: "To learn more visit our website below\n"
                                    ),
                                    TextSpan(
                                        style: linkText,
                                        text: "            www.ywcaofbombay.co.in",
                                        recognizer: TapGestureRecognizer()..onTap =  () async{
                                          var url = "http://www.ywcaofbombay.co.in/";
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        }
                                    ),
                                  ],
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
