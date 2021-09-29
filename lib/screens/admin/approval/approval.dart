import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../drawers_constants/admin_drawer.dart';
import '../../../models/User.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/blue_bubble_design.dart';
import '../../../widgets/alert_dialogs.dart';

// ignore: must_be_immutable
class ApprovalScreen extends StatefulWidget {
  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  final DrawerScaffoldController controller = DrawerScaffoldController();
  late int selectedMenuItemId;
  var userInfo;

  @override
  void initState() {
    selectedMenuItemId = menuWithIcon.items[6].id;
    userInfo = Provider.of<UserData>(context, listen: false);
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
                        Icons.menu,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () => {
                        controller.toggle(Direction.left),
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
                      Text(
                        'Approval',
                        style: TextStyle(
                          fontSize: 26,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ),
                // card view for approval
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
      stream: FirebaseFirestore.instance.collection('approval').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}' + 'something');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No new requests yet!!!!',
                ),
              );
            } else {
              print(snapshot.data!.docs);
              return ListView(
                padding: EdgeInsets.only(bottom: 80),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
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

                            // start of approve and disapprove button
                            Row(
                              children: [
                                Spacer(),
                                Spacer(),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        // Alert box for approve
                                        return AlertDialog(
                                          title: Text('Confirmation'),
                                          content: Text(
                                              'Are you sure you want to approve?'),
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
                                                // update user table
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(document.id)
                                                    .update({
                                                  "address":
                                                      document['address'],
                                                  "firstName":
                                                      document["firstName"],
                                                  "lastName":
                                                      document["lastName"],
                                                  "dateOfBirth":
                                                      document["dateOfBirth"],
                                                  "emailId":
                                                      document["emailId"],
                                                  "gender": document["gender"],
                                                  "profession":
                                                      document["profession"],
                                                  "placeOfWork":
                                                      document["placeOfWork"],
                                                  "nearestCenter":
                                                      document["nearestCenter"],
                                                  "interestInMembership":
                                                      document[
                                                          "interestInMembership"],
                                                  "uid": document["uid"],
                                                  "phoneNumber":
                                                      document["phoneNumber"],
                                                  "memberRole":
                                                      document["memberRole"],
                                                }).then((value) =>
                                                        print("Approved"));
                                                // delete from approval
                                                FirebaseFirestore.instance
                                                    .collection('approval')
                                                    .doc(document.id)
                                                    .delete();
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
                                    Icons.check,
                                  ),
                                ),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () async {
                                    // Alert box for disapprove approval
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Confirmation'),
                                          content: Text(
                                            'Are you sure you want to disapprove?',
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
                                                // not approved
                                                // change approvalStatus
                                                FirebaseFirestore.instance
                                                    .collection('approval')
                                                    .doc(document.id)
                                                    .delete();
                                                // setState(() {});
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
                                    Icons.cancel,
                                  ),
                                ),
                              ],
                            ),
                            // end of approve and disapprove
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
    );
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
