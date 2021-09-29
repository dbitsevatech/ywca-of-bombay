import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../drawers_constants/admin_drawer.dart';
import '../../../models/User.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/blue_bubble_design.dart';

class AnalyticsDetail extends StatefulWidget {
  String eventId, eventName, eventDate;
  int eventClicks, eventRegister;
  AnalyticsDetail({
    required this.eventId,
    required this.eventDate,
    required this.eventName,
    required this.eventRegister,
    required this.eventClicks,
  });
  @override
  _AnalyticsDetailState createState() => _AnalyticsDetailState(
        eventId: this.eventId,
        eventDate: this.eventDate,
        eventName: this.eventName,
        eventRegister: this.eventRegister,
        eventClicks: this.eventClicks,
      );
}

class _AnalyticsDetailState extends State<AnalyticsDetail> {
  var responseList = [];
  List<dynamic> registrationsList = [];
  String eventId, eventName, eventDate;
  int eventClicks, eventRegister;
  var userInfo;
  final DrawerScaffoldController controller = DrawerScaffoldController();
  late int selectedMenuItemId;
  _AnalyticsDetailState({
    required this.eventId,
    required this.eventDate,
    required this.eventName,
    required this.eventRegister,
    required this.eventClicks,
  });
  @override
  void initState() {
    selectedMenuItemId = menuWithIcon.items[6].id;
    userInfo = Provider.of<UserData>(context, listen: false);
    super.initState();
  }

  Future downloadData() async {
    await FirebaseFirestore.instance
        .collection('eventRegistration')
        .where('eventID', isEqualTo: eventId)
        .get()
        .then((querySnapshot) async {
      querySnapshot.docs.forEach((result) {
        // print(result.id);
        responseList.add(
          result.data()["userID"],
        );
      });
      responseList.forEach((element) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(element)
            .get()
            .then((doc) {
          if (doc.exists) {
            registrationsList.add(doc.data());
          }
        });
      });
    });
    await Future.delayed(const Duration(seconds: 2));
    return registrationsList;
  }

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      //appBar: AppBar(), // green app bar
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
                      fontWeight: FontWeight.w800,
                      fontSize: 18.0,
                      color: Colors.black87,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(true);
                    },
                  ),
                ),
              ),
              // Approval & Search bar Starts
              PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Distance from ywca
                    // or else it will overlap
                    SizedBox(height: 150),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText2,
                        children: [
                          TextSpan(
                              text: eventName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Distance from ywca
                    // or else it will overlap
                    SizedBox(height: 250),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText2,
                        children: [
                          TextSpan(
                              text: "Registrations",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 160.0, 0.0, 0.0),
                  child: getHomePageBody(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget getHomePageBody(BuildContext context) {
    return Container(
        child: FutureBuilder(
      future: downloadData(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text(
              'Please wait its loading...',
            ),
          );
        } else {
          if (registrationsList.isEmpty) {
            return Center(
              child: Text(
                'NO REGISTRATIONS YET',
              ),
            );
          } else {
            return ListView(
              padding: EdgeInsets.only(bottom: 80),
              children: registrationsList.map((var document) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: Card(
                    child: ListTile(
                      // name
                      title: Text(
                        'Name: ' +
                            (document['firstName']) +
                            " " +
                            (document['lastName']),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5),
                          // contact number
                          Text(
                            'Contact Number: ' + (document['phoneNumber']),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 5),
                          // email id
                          Text(
                            'Email Id: ' + (document['emailId']),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 5),
                          // address
                          Text(
                            'Address: ' + (document['address']),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 5),
                          // nearest ywca center
                          Text(
                            'YWCA Center: ' + (document['nearestCenter']),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                );
              }).toList(),
            );
          }
        }
      },
    ));
  }
}

gotoApproveUser(BuildContext context, String id) async {
  await FirebaseFirestore.instance
      .collection("approval")
      .where('uid', isEqualTo: id)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach(
      (doc) {
        doc.reference.delete();
      },
    );
  });
}
