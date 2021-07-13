import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'user_events.dart';
import '../about_us/become_member.dart';
import '../../models/User.dart';
import '../../widgets/blue_bubble_design.dart';
import '../../widgets/constants.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  String id,
      eventAmount,
      eventDescription,
      eventName,
      eventImageUrl,
      eventVenue,
      eventType,
      memberRole;
  DateTime eventDate, eventDeadline;
  String eventTime;

  DetailPage({
    required this.id,
    required this.eventAmount,
    required this.eventDescription,
    required this.eventName,
    required this.eventImageUrl,
    required this.eventVenue,
    required this.eventType,
    required this.eventDate,
    required this.eventDeadline,
    required this.eventTime,
    required this.memberRole,
  });
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var userInfo;
  String? memberRole;
  int _currentIndex = 0;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validationGetText

  // onRegister for counting registration by the user
  void insertIntoOnRegistration(String eventID, String eventName) async {
    final User? user = auth.currentUser;
    final userID = user?.uid;
    FirebaseFirestore.instance
        .collection('eventRegistration')
        .where('eventID', isEqualTo: eventID)
        .where('userID', isEqualTo: userID)
        .get()
        .then(
      (checkSnapshot) {
        print('snapshot size');
        print(checkSnapshot.size);
        if (checkSnapshot.size > 0) {
          print("Already Exists");
        } else {
          print("adding");
          FirebaseFirestore.instance
              .collection('eventRegistration')
              .add({'eventID': eventID, 'userID': userID});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    // fetching the values
    String id = widget.id,
        eventAmount = widget.eventAmount,
        eventDescription = widget.eventDescription,
        eventName = widget.eventName,
        eventImageUrl = widget.eventImageUrl,
        eventVenue = widget.eventVenue,
        eventType = widget.eventType;
    DateTime eventDate = widget.eventDate;
    DateTime eventDeadline = widget.eventDeadline;
    String eventTime = widget.eventTime;
    // event date
    String formattedEventDate = DateFormat('dd-MM-yyyy').format(eventDate);
    // event deadline
    String formattedDeadlineDate =
        DateFormat('dd-MM-yyyy').format(eventDeadline);

    // carousel images
    final List<String> imagesList = [
      eventImageUrl,
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
    ];

    @override
    void initState() {
      userInfo = Provider.of<UserData>(context, listen: false);
      memberRole = userInfo.getmemberRole;
      print(memberRole);
      super.initState();
      id = widget.id;
      eventName = widget.eventName;
      eventAmount = widget.eventAmount;
      eventDescription = widget.eventDescription;
      eventVenue = widget.eventVenue;
      eventImageUrl = widget.eventImageUrl;
      eventDate = widget.eventDate;
      eventType = widget.eventType;
      // event_deadline = widget.event_deadline;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    MainPageBlueBubbleDesign(),
                    IconButton(
                      padding: EdgeInsets.only(left: _width * 0.04),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () => {
                        //do something
                        goBackToPreviousScreen(context),
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(_width * 0.3,
                            _width * 0.03, _width * 0.1, _width * 0.1),
                        // YWCA text
                        child: Text(
                          "YWCA Of Bombay",
                          style: TextStyle(
                            fontFamily: 'LobsterTwo',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    IconButton(
                      padding: EdgeInsets.only(left: _width * 0.85),
                      icon: Icon(
                        Icons.share,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                    // Event type displaying
                    if (eventType == 'Everyone')
                      Column(
                        children: <Widget>[
                          Container(
                            // color: Colors.orange,
                            padding: EdgeInsets.only(
                                top: _height * 0.07, left: _height * 0.3),
                            child: RaisedButton(
                              onPressed: () {},
                              color: Color(0xFF00bbe4),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "Everyone",
                                style: new TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (eventType == 'Members')
                      Column(
                        children: <Widget>[
                          Container(
                            // color: Colors.orange,
                            padding: EdgeInsets.only(
                                top: _height * 0.07, left: _height * 0.195),
                            child: RaisedButton(
                              onPressed: () {
                                goToBecomeMember(context);
                              },
                              color: Color(0xFF00bbe4),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "⭐ Members only",
                                style: new TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (memberRole != 'Member')
                      Column(
                        children: <Widget>[
                          Container(
                            // color: Colors.orange,
                            padding: EdgeInsets.only(
                                top: _height * 0.14, left: _height * 0.195),
                            child: RaisedButton(
                              onPressed: () {
                                goToBecomeMember(context);
                              },
                              color: Color(0xFF00bbe4),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "Become a member",
                                style: new TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Positioned(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: _height * 0.15),
                        ),
                      ),
                    ),
                  ],
                ),
                // Carousel
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(
                        () {
                          _currentIndex = index;
                        },
                      );
                    },
                  ),
                  items: imagesList
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            margin: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            elevation: 6.0,
                            shadowColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Image.network(
                                    item,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imagesList.map((urlOfItem) {
                    int index = imagesList.indexOf(urlOfItem);
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 2.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? Color.fromRGBO(0, 0, 0, 0.8)
                            : Color.fromRGBO(0, 0, 0, 0.3),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: _height * 0.015,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: _height * 0.01,
                    horizontal: _width * 0.04,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        // Event Name
                        Text(
                          eventName,
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xff000000),
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        // Event description
                        Text(
                          eventDescription,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        // Event venue
                        Text(
                          'Venue: ' + eventVenue,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        // Event amount
                        Text(
                          'Amount: ' + eventAmount,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        //Date of Event
                        Text(
                          'Date of Event: ' + formattedEventDate,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: _height * 0.015),
                        // Time
                        Text(
                          'Event Time: ' + eventTime,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: _height * 0.015),
                        // event type
                        Text(
                          'Event Type: ' + eventType,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                        ),
                        //Deadline of Event
                        SizedBox(height: _height * 0.015),
                        // Register button
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: _height * 0.015,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                firstButtonGradientColor,
                                firstButtonGradientColor,
                                secondButtonGradientColor
                              ],
                              begin: FractionalOffset.centerLeft,
                              end: FractionalOffset.centerRight,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: 1,
                            child: TextButton(
                              child: Text(
                                'Register',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                insertIntoOnRegistration(id, eventName);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

goBackToPreviousScreen(BuildContext context) {
  // Navigator.pop(context);
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Events()),
  );
}

goToBecomeMember(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BecomeMemberScreen()),
  );
}
