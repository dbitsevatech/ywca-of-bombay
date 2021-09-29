import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';

import '../../../widgets/blue_bubble_design.dart';
import '../../../widgets/zoom_image.dart';

// ignore: must_be_immutable
class AdminEventDetailPage extends StatefulWidget {
  String id,
      eventAmount,
      eventDescription,
      eventName,
      eventImageUrl,
      eventVenue,
      eventType;
  DateTime eventDate, eventDeadline;
  String eventTime;

  AdminEventDetailPage({
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
  });
  @override
  _AdminEventDetailPageState createState() =>
      _AdminEventDetailPageState(id, eventImageUrl);
}

class _AdminEventDetailPageState extends State<AdminEventDetailPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String id;
  late String eventImageUrl;
  int clicks = 0;
  int registrations = 0;

  _AdminEventDetailPageState(this.id, this.eventImageUrl);

  void analyticsData() async {
    await FirebaseFirestore.instance
        .collection('eventRegistration')
        .where('eventID', isEqualTo: id)
        .get()
        .then((querySnapshot) {
      setState(() {
        registrations += querySnapshot.size;
      });
    });
    await FirebaseFirestore.instance
        .collection('eventClick')
        .where('eventID', isEqualTo: id)
        .get()
        .then((querySnapshot) {
      setState(() {
        clicks += querySnapshot.size;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    analyticsData();
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
    id = widget.id;
    String eventAmount = widget.eventAmount,
        eventDescription = widget.eventDescription,
        eventName = widget.eventName,
        eventVenue = widget.eventVenue,
        eventType = widget.eventType;
    DateTime eventDate = widget.eventDate;
    DateTime eventDeadline = widget.eventDeadline;
    String eventTime = widget.eventTime;

    // event date conversion to string for displaying
    String formattedEventDate =
        DateFormat('dd MMM, yyyy', 'en').format(eventDate);

    // event deadline conversion to string for displaying
    String formattedDeadlineDate =
        DateFormat('dd MMM yyyy', 'en').format(eventDeadline);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              children: <Widget>[
                AdminDetailPageBlueBubbleDesign(),
                SizedBox(
                  height: _height * 0.05,
                ),
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
                      SizedBox(height: _height * 0.015),
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
                      SizedBox(
                        height: _height * 0.015,
                      ),
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
                      SizedBox(
                        height: _height * 0.015,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(_width * 0.08, 0.0, 0, 0.0),
                        child: Text(
                          'Clicks:  ' + clicks.toString(),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.015,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(_width * 0.08, 0.0, 0, 0.0),
                        child: Text(
                          'Registrations: ' + registrations.toString(),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      //Deadline of Event
                      SizedBox(height: _height * 0.015),
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
  Navigator.pop(context);
}
