import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

import './authentication/login.dart';
import '../widgets/blue_bubble_design.dart';
import '../widgets/gradient_button.dart';
import '../models/User.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var userInfo;
  final List<String> images = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
    'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  @override
  void initState() {
    userInfo = Provider.of<UserData>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      images.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    // final _width = MediaQuery.of(context).size.width;
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
                  // Positioned(
                  //   child: Image.asset("assets/images/circle-design.png"),
                  // ),
                  DetailPageBlueBubbleDesign(),
                  Positioned(
                    child: AppBar(
                      centerTitle: true,
                      title: Text(
                        "YWCA Of Bombay",
                        style: TextStyle(
                            fontFamily: 'LobsterTwo',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            color: Colors.black87),
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
              // https://pub.dev/packages/intro_slider ***
              CarouselSlider.builder(
                itemCount: images.length,
                options: CarouselOptions(
                  // Changes the size of the carousel (and also messes up the blue bubble design
                  //
                  // https://medium.com/flutter-community/flutter-web-getting-started-with-responsive-design-231511ef15d3
                  // https://stackoverflow.com/questions/61207980/create-a-flutter-carousel-slider-with-dynamic-heigth-for-each-page
                  //
                  // aspectRatio: 1.4, // Pixel 2 and Moto G5s plus
                  aspectRatio: 1, // Redmi 8 and pixel 4xl
                  // aspectRatio: 1.1, // Nokia 7 plus
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: Duration(milliseconds: 700),
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  // height: _height * 0.45, //distorta everything
                ),
                itemBuilder: (context, index, realIdx) {
                  return Container(
                    height: 100,
                    child: Center(
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                        width: 1000, // No effect on changing value
                      ),
                    ),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Center(
                    //   child:
                    Text(
                      '\"BY LOVE, SERVE ONE ANOTHER\"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'To empower women at all levels to struggle for justice',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                  child: GradientButton(
                    buttonText: "Let's Go!",
                    screenHeight: _height,
                    onPressedFunction: () async {
                      var user = await FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        print(user.phoneNumber);
                        var checkuser = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .get();
                        // print(checkuser.data());
                        final userdata = checkuser.data();
                        userInfo.updateAfterAuth(
                            userdata!['uid'],
                            userdata['firstName'],
                            userdata['lastName'],
                            userdata['dateOfBirth'].toDate(),
                            userdata['emailId'],
                            userdata['phoneNumber'],
                            userdata['gender'],
                            userdata['profession'],
                            userdata['placeOfWork'],
                            userdata['nearestCenter'],
                            userdata['interestInMembership'],
                            userdata['memberRole']);
                        // if (userdata['memberRole'] == 'none') {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) => MainWidget()));
                        // } else if (userdata['memberRole'] == 'Admin') {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) => AdminMainWidget()));
                        // }
                      } else {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
