import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'user_events.dart';

import '../about_us/become_member.dart';
import '../../models/User.dart';
import '../../widgets/blue_bubble_design.dart';
import '../../widgets/constants.dart';
import '../../widgets/alert_dialogs.dart';
import '../../widgets/zoom_image.dart';

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
  _DetailPageState createState() => _DetailPageState(eventImageUrl);
}

class _DetailPageState extends State<DetailPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var userInfo;
  String memberRole = "";
  int _currentIndex = 0;
  String role = "";
  var now = new DateTime.now();
  late String eventImageUrl;
  _DetailPageState(this.eventImageUrl);

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validationGetText

  Widget _buildImage() {
    // ignore: unnecessary_null_comparison
    if (eventImageUrl != "") {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          child: Image.network(
            eventImageUrl,
            height: 300,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ZoomImageNetwork(eventImageUrl),
              ),
            );
          },
        ),
      );
    } else {
      return SizedBox(
        height: 10,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    userInfo = Provider.of<UserData>(context, listen: false);
    role = userInfo.getmemberRole;
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
    String formattedEventDate =
        DateFormat('EEE | dd MMM, yyyy').format(eventDate);
    // event deadline
    String formattedDeadlineDate =
        DateFormat('dd MMM, yyyy').format(eventDeadline);

    // carousel images
    // final List<String> imagesList = [
    //   eventImageUrl,
    //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    //   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    //   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
    // ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "YWCA Of Bombay",
          style: TextStyle(
            fontFamily: 'LobsterTwo',
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.black87,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.black,
            ),
            tooltip: 'Comment Icon',
            onPressed: () {
              final RenderBox box = context.findRenderObject() as RenderBox;
              Share.share(
                  eventName +
                      '\n' +
                      eventDescription +
                      "\n\n Samara pires \n+91 8899696969 \nsamf@gmail.com\n\n" +
                      "Shoba balla \n+91 98333 93953",
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
            },
          ), //IconButton
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => {
            goBackToPreviousScreen(context),
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AdminDetailPageBlueBubbleDesign(),

                // show it when the event is for members and the user is not a member
                // then become a member button is show
                if (role != 'Member' && eventType != 'Members only') ...[
                  Padding(
                      padding: EdgeInsets.fromLTRB(_width * 0.35, 0, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          goToBecomeMember(context);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF00bbe4),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          "Become a member",
                          style: new TextStyle(
                              fontSize: 18.0, color: Colors.white),
                        ),
                      )),
                ],
                Center(child: _buildImage()),
                SizedBox(
                  height: _height * 0.015,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: _height * 0.01,
                    horizontal: _width * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Event title
                      Text(
                        eventName,
                        style: TextStyle(
                          fontSize: 26,
                          color: Color(0xff000000),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.015,
                      ),
                      SizedBox(
                        height: _height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Event Venue
                          Text(
                            'Venue: ' + eventVenue,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 5),
                          // Event time
                          Text(
                            // TODO: Time in 12 hr format (AM/PM)
                            'Time: ' + eventTime,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Event Amount
                          Text(
                            'Amount: ' + eventAmount,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          // Event date
                          Text(
                            'Date: ' + formattedEventDate,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Event Type
                          Text(
                            'Event for: ' + eventType,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          // Event registration deadline
                          Text(
                            'Deadline: ' + formattedDeadlineDate,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: _height * 0.015),
                      // Event description
                      Text(
                        eventDescription,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: _height * 0.015),
                      // Register button
                      if ((role == 'Member' || role == 'Staff') &&
                          eventType == 'Members only' &&
                          eventDeadline.compareTo(now) > 0) ...[
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
                                showRegisterAlertDialog(
                                    context, id, eventName, auth);
                              },
                            ),
                          ),
                        ),
                      ],
                      if (role == 'NonMember' &&
                          eventType == 'Members only' &&
                          eventDeadline.compareTo(now) > 0) ...[
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
                                'Become a Member',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                goToBecomeMember(context);
                              },
                            ),
                          ),
                        ),
                      ],
                      if (eventType == 'Everyone' &&
                          eventDeadline.compareTo(now) > 0) ...[
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
                                showRegisterAlertDialog(
                                    context, id, eventName, auth);
                              },
                            ),
                          ),
                        ),
                      ],
                      SizedBox(height: _height * 0.015),
                      if (eventDeadline.compareTo(now) < 0) ...[
                        Center(
                          child: Text(
                            'Event Date has passed\n'
                            'Contact 8828024246 for more details',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ],
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
