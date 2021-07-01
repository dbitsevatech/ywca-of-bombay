import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../../widgets/constants.dart';
import 'package:kf_drawer/kf_drawer.dart';
import '../../../widgets/blue_bubble_design.dart';
import 'admin_new_event.dart';
import 'admin_edit_event.dart';
import 'admin_event_details.dart';

// ignore: must_be_immutable
class AdminEvents extends KFDrawerContent {
  @override
  _AdminEventsState createState() => _AdminEventsState();
}

class _AdminEventsState extends State<AdminEvents> {
  Future<bool> _navigateToRoute(String name) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name),
          actions: <Widget>[
            TextButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('YES'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
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
            title: Text("YWCA Of Bombay",
                style: new TextStyle(
                    fontFamily: 'LilyScriptOne',
                    fontSize: 18.0,
                    color: Colors.black87)),
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
          child: new Column(
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
                        style: new TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
                        borderSide: BorderSide.none),
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
    )));
  }

  Widget getHomePageBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('events').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}' + 'something');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return new ListView(
              padding: EdgeInsets.only(bottom: 80),
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: Card(
                    child: ListTile(
                      leading: new Image.network(
                        document['eventImageUrl'],
                        fit: BoxFit.cover,
                        width: 120.0,
                      ),
                      title: new Text(
                        'Date:' +
                            (readEventDate(document['eventDate'])) +
                            '| Time:' +
                            (readEventTime(document['eventTime'])),
                        style: new TextStyle(
                            color: Color(0xFF49DEE8),
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal),
                      ),
                      subtitle: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5),
                          new Text(document['eventName'],
                              style: new TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          new Text('Resource Person: ' + document['eventName'],
                              style: new TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.normal)),
                          SizedBox(height: 5),
                          new Text('Venue: ' + document['eventVenue'],
                              style: new TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.normal)),
                          SizedBox(height: 5),
                          new Text('Amount: ' + document['eventAmount'],
                              style: new TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.normal)),
                          // start of edit and delete
                          Row(
                            children: [
                              Spacer(),
                              Spacer(),
                              Spacer(),
                              ElevatedButton(
                                onPressed: () async {
                                  bool result = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Confirmation'),
                                        content: Text(
                                            'Are you sure you want to edit this event?'),
                                        actions: <Widget>[
                                          new TextButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(
                                                      false); // dismisses only the dialog and returns false
                                            },
                                            child: Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(true);
                                              gotoEditEvent(
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
                                            child: Text('Yes'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green),
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
                                  bool result = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Confirmation'),
                                        content: Text(
                                            'Are you sure you want to delete this event?'),
                                        actions: <Widget>[
                                          new TextButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(
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
                        print('ontap');
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
            eventTime: eventTime)),
  );
}

gotoEditEvent(
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

// event deadline
  DateTime newEventDeadline = eventDeadline.toDate();

// event time
  DateTime newEventTime = eventTime.toDate();

  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => AdminEditEvent(
            id: id,
            eventAmount: eventAmount,
            eventDescription: eventDescription,
            eventName: eventName,
            eventImageUrl: eventImageUrl,
            eventVenue: eventVenue,
            eventType: eventType,
            eventDate: newEventDate,
            eventDeadline: newEventDeadline,
            eventTime: newEventTime)),
  );
}

gotoNewEvent(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AdminNewEvent()),
  );
}
