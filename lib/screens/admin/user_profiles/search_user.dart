import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ywcaofbombay/screens/admin/events/admin_events.dart';
import 'DataController.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../../drawers_constants/admin_drawer.dart' as AdminDrawer;
import 'user_profile_details.dart';

class SearchUser extends StatefulWidget {
  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final DrawerScaffoldController controller = DrawerScaffoldController();
  late int selectedMenuItemId;
  final TextEditingController searchController = new TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  late QuerySnapshot snapshotData;
  bool isExecuted = false;
  final _navigatorKey = GlobalKey<NavigatorState>(); //define a navigation key.

  @override
  void initState() {
    super.initState();
    selectedMenuItemId = AdminDrawer.menuWithIcon.items[7].id;
  }

  Widget build(BuildContext context) {
    Widget searchData() {
      return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // go to detail screen
              goToUserProfileDetails(
                  context,
                  snapshotData.docs[index].get('uid'),
                  snapshotData.docs[index].get('firstName'),
                  snapshotData.docs[index].get('lastName'),
                  snapshotData.docs[index].get('phoneNumber'),
                  snapshotData.docs[index].get('emailId'),
                  snapshotData.docs[index].get('address'),
                  snapshotData.docs[index].get('dateOfBirth'),
                  snapshotData.docs[index].get('memberRole'),
                  snapshotData.docs[index].get('gender'),
                  snapshotData.docs[index].get('nearestCenter'),
                  snapshotData.docs[index].get('placeOfWork'),
                  snapshotData.docs[index].get('profession'),
                  snapshotData.docs[index].get('interestInMembership'));
            },
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(snapshotData.docs[index].get('firstName') +
                    " " +
                    snapshotData.docs[index].get('lastName')),
              ),
            ),
          );
        },
      );
    }

    return WillPopScope(
      onWillPop: () => goBackToPreviousScreen(context),
      child: new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            GetBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.black,
                    onPressed: () {
                      print("in pressed");
                      val.queryData(searchController.text).then((value) {
                        snapshotData = value;
                        setState(() {
                          isExecuted = true;
                        });
                      });
                    });
              },
            )
          ],
          title: TextField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                hintText: "Search user by name",
                hintStyle: TextStyle(color: Colors.black)),
            controller: searchController,
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => goBackToPreviousScreen(context),
          ),
          backgroundColor: Colors.white,
        ),
        body: isExecuted
            ? searchData()
            : Container(
                child: Center(
                  child: Text(
                    'Press Search Button to Load Users',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 2.5,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  goToUserProfileDetails(
      BuildContext context,
      String uid,
      String firstName,
      String lastName,
      String phoneNumber,
      String emailId,
      String address,
      Timestamp dateOfBirth,
      String memberRole,
      String gender,
      String nearestCenter,
      String placeOfWork,
      String profession,
      String interestInMembership) {
    DateTime newdateOfBirth = dateOfBirth.toDate();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileDetails(
          uid: uid,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          emailId: emailId,
          address: address,
          dateOfBirth: newdateOfBirth,
          memberRole: memberRole,
          gender: gender,
          nearestCenter: nearestCenter,
          placeOfWork: placeOfWork,
          profession: profession,
          interestInMembership: interestInMembership,
        ),
      ),
    );
  }
}

goBackToPreviousScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AdminEvents()),
  );
}
