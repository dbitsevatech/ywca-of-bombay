import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'user_event_details.dart';
import '../../widgets/blue_bubble_design.dart';
import '../../widgets/constants.dart';
import '../../models/User.dart';
import '../../drawers_constants/user_drawer.dart';
import '../../widgets/alert_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// ignore: must_be_immutable
class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final DrawerScaffoldController controller = DrawerScaffoldController();
  late int selectedMenuItemId;
  // Firebase auth for couting the onClick and Onregister count of event
  final FirebaseAuth auth = FirebaseAuth.instance;
  var userInfo;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // conversion of event date for displaying
  String readEventDate(Timestamp eventDate) {
    DateTime newEventDate = eventDate.toDate();
    String formattedEventDate =
        DateFormat('EEE, dd MMM, yyyy').format(newEventDate);
    return formattedEventDate;
  }

  _openPopup(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hey there, interested in being a member?'),
            content: Text(
                'For Membership details go to the About us page of the app or get in touch with your nearest YWCA now'),
            actions: <Widget>[
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK!',
                  ),
                ),
              ),
            ],
          );
        });
  }

  // onClick for counting number of clicks by the user
  void insertIntoOnClick(String eventID, String eventName) async {
    final User? user = auth.currentUser;
    final userID = user?.uid;
    // adding to eventClick
    FirebaseFirestore.instance
        .collection('eventClick')
        .where('eventID', isEqualTo: eventID)
        .where('userID', isEqualTo: userID)
        .get()
        .then((checkSnapshot) {
      if (checkSnapshot.size > 0) {
      } else {
        // incrementing eventClickCount in events
        final DocumentReference docRef =
            FirebaseFirestore.instance.collection("events").doc(eventID);
        docRef.update({"eventClickCount": FieldValue.increment(1)});
        print("adding");
        FirebaseFirestore.instance
            .collection('eventClick')
            .add({'eventID': eventID, 'userID': userID});
      }
    });
  }

  Future checkMemberPopup() async {
    userInfo = Provider.of<UserData>(context, listen: false);
    // sharepreferences instance
    SharedPreferences prefsMember = await SharedPreferences.getInstance();
    // boolean variable getting the value of member_popup
    bool _checkMember = (prefsMember.getBool('member_popup') ?? false);
    if (userInfo.getmemberRole == "NonMember") {
      if (_checkMember) {
        // dont show the popup
      } else {
        // show the popup and set member_popup = true
        await prefsMember.setBool('member_popup', true);
        // _openPopup(context);
        Timer(Duration(seconds: 3), () {
          _openPopup(context);
        });
      }
    }
  }

  // insert token into the database
  _getToken() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user?.uid;
    _firebaseMessaging.getToken().then((deviceToken) {
      print("device token: $deviceToken");
      // adding to mobile token
      FirebaseFirestore.instance
          .collection('mobileToken')
          .where('userID', isEqualTo: userID)
          .get()
          .then((checkSnapshot) {
        if (checkSnapshot.size > 0) {
          print("already exists");
        } else {
          // saving the value if it doesn't exists
          print("adding");
          FirebaseFirestore.instance
              .collection('mobileToken')
              .add({'token': deviceToken, 'userID': userID});
        }
      });
    });
  }

  @override
  void initState() {
    selectedMenuItemId = menuWithIcon.items[1].id;
    checkMemberPopup();
    initializeDateFormatting('en', null);
    _getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitAlertDialog(context),
      child: DrawerScaffold(
        // appBar: AppBar(), // green app bar
        drawers: [
          SideDrawer(
            percentage: 0.75, // main screen height proportion
            headerView: header(context, userInfo),
            footerView: footer(context, controller, userInfo),
            color: successStoriesCardBgColor,
            selectorColor: Colors.indigo[600],
            menu: menuWithIcon,
            animation: true,
            // color: Theme.of(context).primaryColorLight,
            selectedItemId: selectedMenuItemId,
            onMenuItemSelected: (itemId) {
              setState(() {
                selectedMenuItemId = itemId;
                selectedItem(context, itemId);
              });
            },
          )
        ],
        controller: controller,
        builder: (context, id) => SafeArea(
          child: Center(
            child: Stack(
              children: <Widget>[
                EventPageBlueBubbleDesign(),
                Positioned(
                  child: AppBar(
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
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () => {
                        controller.toggle(Direction.left),
                        // OR
                        // controller.open()
                      },
                    ),
                  ),
                ),
                // Events & Search bar Starts
                PreferredSize(
                  preferredSize: Size.fromHeight(80),
                  child: Column(
                    children: <Widget>[
                      // Distance from ywca
                      // or else it will overlap
                      SizedBox(height: 80),
                      Center(
                        child: Text(
                          'Events',
                          style: TextStyle(
                            fontSize: 26,
                            color: Color(0xff333333),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                // card view for the events
                Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 160.0, 0.0, 0.0),
                    child: getHomePageBody(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getHomePageBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('events')
          .orderBy('eventDate', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}' + 'something');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return ListView(
              padding: EdgeInsets.only(bottom: 100),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: Card(
                    child: ListTile(
                      minVerticalPadding: 10,
                      title: Column(
                        children: [
                          // Event image
                          ClipRRect(
                            borderRadius: BorderRadius.all(
                              // add border radius here
                              Radius.circular(10.0),
                            ),
                            child: Image.network(
                              // add image location here
                              document['eventImageUrl'],
                              fit: BoxFit.fitWidth,
                              // // width: 200,
                            ),
                          ),
                          SizedBox(height: 5),
                          // Event name
                          Text(
                            document['eventName'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          // Resource person
                          Text(
                            // TODO: Resource person in DB
                            'Resource Person: Sharon Pires',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Event Venue
                              Text(
                                'Venue: ' + document['eventVenue'],
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 5),
                              // Event time
                              Text(
                                // TODO: Time in 12 hr format (AM/PM)
                                'Time: ' + (document['eventTime']),
                                style: TextStyle(
                                  fontSize: 14.0,
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
                                'Amount: ' + document['eventAmount'],
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              // Event date
                              Text(
                                'Date: ' +
                                    (readEventDate(document['eventDate'])),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        insertIntoOnClick(document.id, document['eventName']);
                        gotoDetailEvent(
                            context,
                            document.id,
                            document['eventAmount'],
                            document['eventDescription'],
                            document['eventName'],
                            document['eventImageUrl'],
                            document['eventVenue'],
                            document['eventType'],
                            document['eventDate'],
                            document['eventDeadline'],
                            document['eventTime']);
                      },
                    ),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }

  gotoDetailEvent(
      BuildContext context,
      String id,
      String eventAmount,
      String eventDescription,
      String eventName,
      String eventImageUrl,
      String eventVenue,
      String eventType,
      Timestamp eventDate,
      Timestamp eventDeadline,
      String eventTime) {
    // TimeStamp to DateTime conversion of event date for displaying
    DateTime newEventDate = eventDate.toDate();

    // TimeStamp to DateTime conversion of event deadline for displaying
    DateTime newEventDeadline = eventDeadline.toDate();

    String memberRole = 'null';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          id: id,
          eventAmount: eventAmount,
          eventDescription: eventDescription,
          eventName: eventName,
          eventImageUrl: eventImageUrl,
          eventVenue: eventVenue,
          eventType: eventType,
          eventDate: newEventDate,
          eventDeadline: newEventDeadline,
          eventTime: eventTime,
          memberRole: memberRole,
        ),
      ),
    );
  }
}
