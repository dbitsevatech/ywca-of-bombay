import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider/provider.dart';

import 'user_event_details.dart';

import '../../widgets/blue_bubble_design.dart';
import '../../models/User.dart';

// ignore: must_be_immutable
class Events extends KFDrawerContent {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var userInfo;

  // onClick for counting clicks
  void insertIntoOnClick(String eventID, String eventName) async {
    final User user = auth.currentUser;
    final userID = user.uid;
    FirebaseFirestore.instance
        .collection('eventClick')
        .where('eventID', isEqualTo: eventID)
        .where('userID', isEqualTo: userID)
        .get()
        .then((checkSnapshot) {
      print('snapshot size');
      print(checkSnapshot.size);
      if (checkSnapshot.size > 0) {
        print("Already Exists");
      } else {
        print("adding");
        FirebaseFirestore.instance
            .collection('eventClick')
            .add({'eventID': eventID, 'userID': userID});
      }
    });
  }

  // conversion of event date
  String readEventDate(Timestamp eventDate) {
    DateTime newEventDate = eventDate.toDate();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String onlyTime = dateFormat.format(DateTime.now());
    String formattedEventDate = DateFormat('dd-MM-yyyy').format(newEventDate);
    return formattedEventDate;
  }

  // conversion of event time
  String readEventTime(Timestamp eventTime) {
    DateTime newEventTime = eventTime.toDate();
    String formattedEventTime = DateFormat('kk:mm:a').format(newEventTime);
    return formattedEventTime;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Stack(
          children: <Widget>[
            EventPageBlueBubbleDesign(),
            Positioned(
              child: AppBar(
                centerTitle: true,
                title: Text(
                  "YWCA Of Bombay",
                  style: TextStyle(
                      fontFamily: 'LilyScriptOne',
                      fontSize: 18.0,
                      color: Colors.black87),
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
            PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Column(
                children: <Widget>[
                  // Distance from ywca
                  // or else it will overlap
                  SizedBox(height: 80),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: [
                        TextSpan(
                          text: 'Events ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        WidgetSpan(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(Icons.notification_important),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Search by venue",
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        suffixIcon: Icon(
                          Icons.mic,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: Colors.transparent),
                  ),
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
    );
  }

  @override
  void initState() {
    userInfo = Provider.of<UserData>(context, listen: false);
    super.initState();
  }

  Widget getHomePageBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('events').snapshots(),
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
              padding: EdgeInsets.only(bottom: 80),
              children: snapshot.data.docs.map(
                (DocumentSnapshot document) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 10,
                    ),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(
                          document['eventImageUrl'],
                          fit: BoxFit.cover,
                          width: 120.0,
                        ),
                        title: Text(
                          'Date:' +
                              (readEventDate(document['eventDate'])) +
                              '| Time:' +
                              (readEventTime(document['eventTime'])),
                          style: TextStyle(
                            color: Color(0xFF49DEE8),
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5),
                            Text(
                              document['eventName'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Resource Person: ' + document['eventName'],
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Venue: ' + document['eventVenue'],
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Amount: ' + document['eventAmount'],
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          print('ontap');
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
                            document['eventTime'],
                          );
                        },
                      ),
                    ),
                  );
                },
              ).toList(),
            );
        }
      },
    );
  }
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
    Timestamp eventTime) {
  // event date
  DateTime newEventDate = eventDate.toDate();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  String onlyTime = dateFormat.format(DateTime.now());
// // event deadline
  DateTime newEventDeadline = eventDeadline.toDate();
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
      ),
    ),
  );
}
