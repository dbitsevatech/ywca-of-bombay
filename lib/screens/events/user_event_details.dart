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
  _DetailPageState createState() => _DetailPageState(eventImageUrl, id);
}

class _DetailPageState extends State<DetailPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var userInfo;
  String memberRole = "";
  String role = "";
  var now = new DateTime.now();
  late String eventImageUrl, id, userID;
  late bool registered;
  _DetailPageState(this.eventImageUrl, this.id);

  @override
  void initState() {
    userInfo = Provider.of<UserData>(context, listen: false);
    role = userInfo.getmemberRole;
    userID = userInfo.getuid;
    checkIfRegistered();
    super.initState();
  }

  void checkIfRegistered() {
    FirebaseFirestore.instance
        .collection('eventRegistration')
        .where('eventID', isEqualTo: id)
        .where('userID', isEqualTo: userID)
        .get()
        .then((value) {
      if (value.size > 0) {
        setState(() {
          registered = true;
        });
      } else {
        setState(() {
          registered = false;
        });
      }
    });
  }

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
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    // fetching the values
    String id = widget.id,
        eventAmount = widget.eventAmount,
        eventDescription = widget.eventDescription,
        eventName = widget.eventName,
        eventVenue = widget.eventVenue,
        eventType = widget.eventType;
    DateTime eventDate = widget.eventDate;
    DateTime eventDeadline = widget.eventDeadline;
    String eventTime = widget.eventTime;
    // event date
    String formattedEventDate = DateFormat('dd MMM, yyyy').format(eventDate);
    // event deadline
    String formattedDeadlineDate =
        DateFormat('dd MMM yyyy').format(eventDeadline);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "YWCA OF BOMBAY",
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w800,
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
                  "Event: $eventName" +
                      "\nDescription: $eventDescription" +
                      "\n\n Date: $formattedEventDate  Time: $eventTime" +
                      "\nVenue: $eventVenue" +
                      "\n\n Contact before $formattedDeadlineDate to register: " +
                      "\nShoba Balla: +919833393953" +
                      "\nMildin Nadar: +918828024246" +
                      "\n\nDownload app from Google Play to register for the $eventName:" +
                      "\nhttps://play.google.com/store/apps/details?id=com.sevatech.ywca",
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
                if (role == 'NonMember' && eventType == 'Everyone') ...[
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
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(_width * 0.08, 0.0, 0, 0.0),
                        child: Text(
                          eventName,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.015,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(_width * 0.08, 0.0, 0, 0.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.calendar_today_outlined),
                              ),
                              TextSpan(
                                text:
                                    " " + formattedEventDate + ", " + eventTime,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: " | ",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                              WidgetSpan(
                                child: Icon(Icons.location_on),
                              ),
                              TextSpan(
                                text: eventVenue,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.015,
                      ),
                      SizedBox(height: _height * 0.015),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(_width * 0.08, 0.0, 0, 0.0),
                        child: Text(
                          eventDescription,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff000000),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(height: _height * 0.015),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(_width * 0.08, 0.0, 0, 0.0),
                        child: Text(
                          '₹ ' + eventAmount,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(height: _height * 0.015),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(_width * 0.08, 0.0, 0, 0.0),
                        child: Text(
                          'Event for: ' + eventType,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(height: _height * 0.015),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(_width * 0.08, 0.0, 0, 0.0),
                        child: Text(
                          '❌ Deadline: ' + formattedDeadlineDate,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(height: _height * 0.015),
                      // Register button
                      if ((role == 'Member' || role == 'Staff') &&
                          eventType == 'Members only' &&
                          eventDeadline.compareTo(now) >= 0) ...[
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
                                'Register!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                if (registered) {
                                  showAlreadyRegisterAlertDialog(context);
                                } else {
                                  registered = true;
                                  showRegisterAlertDialog(
                                      context, id, eventName, auth);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                      if (role == 'NonMember' &&
                          eventType == 'Members only' &&
                          eventDeadline.compareTo(now) >= 0) ...[
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
                          eventDeadline.compareTo(now) >= 0) ...[
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
                                'Register!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                if (registered) {
                                  showAlreadyRegisterAlertDialog(context);
                                } else {
                                  registered = true;
                                  showRegisterAlertDialog(
                                      context, id, eventName, auth);
                                }
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
