import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/alert_dialogs.dart';

import 'admin_event_details.dart';
import 'admin_edit_event.dart';
import 'admin_new_event.dart';

import '../../../drawers_constants/admin_drawer.dart';
import '../../../models/User.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/blue_bubble_design.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class AdminEvents extends StatefulWidget {
  @override
  _AdminEventsState createState() => _AdminEventsState();
}

class _AdminEventsState extends State<AdminEvents> {
  final DrawerScaffoldController controller = DrawerScaffoldController();
  late int selectedMenuItemId;
  var userInfo;
  var screenSize;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // conversion of event date to string for displaying
  String readEventDate(Timestamp eventDate) {
    DateTime newEventDate = eventDate.toDate();
    String formattedEventDate =
        DateFormat('EEE | dd MMM, yyyy', 'en').format(newEventDate);
    return formattedEventDate;
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
          print("updating token");
          FirebaseFirestore.instance
              .collection('mobileToken')
              .doc(userID)
              .update({'token': deviceToken})
              .then((_) => print('Updated'))
              .catchError((error) => print('Update failed: $error'));
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
    userInfo = Provider.of<UserData>(context, listen: false);
    initializeDateFormatting('en', null);
    _getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
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
            selectorColor: Colors.indigo[600], menu: menuWithIcon,
            animation: true,
            selectedItemId: selectedMenuItemId,
            onMenuItemSelected: (itemId) {
              setState(() {
                selectedMenuItemId = itemId;
                selectedItem(context, itemId);
              });
            },
          ),
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
                        // fontStyle: FontStyle.italic,
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
                      // TextField(
                      //   decoration: InputDecoration(
                      //     hintText: "Search by venue",
                      //     prefixIcon: Icon(
                      //       Icons.search,
                      //       color: Colors.grey,
                      //     ),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //     contentPadding: EdgeInsets.zero,
                      //     filled: true,
                      //     fillColor: Colors.transparent,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // card view for the events
                Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 160.0, 0.0, 0.0),
                    child: getHomePageBody(context)),
                Column(
                  children: [
                    Spacer(flex: 20),
                    Row(
                      children: [
                        Spacer(flex: 15),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed))
                                return secondaryColor.withOpacity(0.90);
                              return firstButtonGradientColor;
                            }),
                            foregroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              return null;
                            }),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          icon: Icon(Icons.add),
                          label: Text(
                            "New Event",
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                          onPressed: () async {
                            // when clicked on new event open Add Event page
                            gotoNewEvent(context);
                          },
                        ),
                        Spacer(),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
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
                          // start of edit and delete button
                          Row(
                            children: [
                              Spacer(flex: 12),
                              ElevatedButton(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      // Alert box for edit event
                                      return AlertDialog(
                                        title: Text('Confirmation'),
                                        content: Text(
                                            'Are you sure you want to edit this event?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(
                                                context,
                                                rootNavigator: true,
                                              ).pop(
                                                  false); // dismisses only the dialog and returns false
                                            },
                                            child: Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(true);
                                              gotoEditEvent2(
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
                                            child: Text('Yes'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(secondaryColor),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(5)),
                                ),
                                child: Icon(
                                  Icons.edit,
                                ),
                              ),
                              Spacer(),
                              ElevatedButton(
                                onPressed: () async {
                                  // Alert box for delete event
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Confirmation'),
                                        content: Text(
                                          'Are you sure you want to delete this event?',
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(
                                                context,
                                                rootNavigator: true,
                                              ).pop(
                                                  false); // dismisses only the dialog and returns false
                                            },
                                            child: Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(true);
                                              var events = FirebaseFirestore
                                                  .instance
                                                  .collection('events');
                                              var eventsBackup =
                                                  FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'eventsBackup');
                                              await events
                                                  .doc(document.id)
                                                  .delete();
                                              await eventsBackup
                                                  .doc(document.id)
                                                  .delete();
                                              await FirebaseStorage.instance
                                                  .refFromURL(
                                                      document['eventImageUrl'])
                                                  .delete();
                                              await FirebaseFirestore.instance
                                                  .collection("eventClick")
                                                  .where('eventID',
                                                      isEqualTo: document.id)
                                                  .get()
                                                  .then((querySnapshot) {
                                                querySnapshot.docs
                                                    .forEach((doc) {
                                                  doc.reference.delete();
                                                });
                                              });
                                              await FirebaseFirestore.instance
                                                  .collection(
                                                      "eventRegistration")
                                                  .where('eventID',
                                                      isEqualTo: document.id)
                                                  .get()
                                                  .then((querySnapshot) {
                                                querySnapshot.docs
                                                    .forEach((doc) {
                                                  doc.reference.delete();
                                                });
                                              });
                                              setState(() {});
                                            },
                                            child: Text('Yes'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(5)),
                                ),
                                child: Icon(
                                  Icons.delete,
                                ),
                              ),
                            ],
                          ),
                          // end of edit and delete
                        ],
                      ),
                      onTap: () {
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
}

gotoNewEvent(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AdminNewEvent()),
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
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AdminEventDetailPage(
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

gotoEditEvent2(
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

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditEventScreen(
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
