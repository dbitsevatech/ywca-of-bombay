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

  @override
  void initState() {
    super.initState();
    selectedMenuItemId = AdminDrawer.menuWithIcon.items[7].id;
  }

  Widget build(BuildContext context) {
    Widget searchData() {
      print('started');
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

    return Scaffold(
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
                  'Search any user by name',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
            ),
    );
    // return WillPopScope(
    //   onWillPop: () => showExitAlertDialog(context),
    //   child: DrawerScaffold(
    //     // appBar: AppBar(), // green app bar
    //     drawers: [
    //       SideDrawer(
    //         percentage: 0.75, // main screen height proportion
    //         // headerView: header(context, userInfo),
    //         // footerView: footer(context, controller, userInfo),
    //         color: successStoriesCardBgColor,
    //         selectorColor: Colors.indigo[600], menu: menuWithIcon,
    //         animation: true,
    //         // color: Theme.of(context).primaryColorLight,
    //         selectedItemId: selectedMenuItemId,
    //         onMenuItemSelected: (itemId) {
    //           setState(() {
    //             selectedMenuItemId = itemId;
    //             selectedItem(context, itemId);
    //           });
    //         },
    //       )
    //     ],
    //     controller: controller,
    //     builder: (context, id) => SafeArea(
    //       child: Center(
    //         child: Stack(
    //           children: <Widget>[
    //             EventPageBlueBubbleDesign(),
    //             Positioned(
    //               child: AppBar(
    //                 centerTitle: true,
    //                 title: Text(
    //                   "YWCA Of Bombay",
    //                   style: TextStyle(
    //                     fontFamily: 'LobsterTwo',
    //                     fontStyle: FontStyle.italic,
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 18.0,
    //                     color: Colors.black87,
    //                   ),
    //                 ),
    //                 backgroundColor: Colors.transparent,
    //                 elevation: 0,
    //                 leading: IconButton(
    //                   icon: Icon(
    //                     Icons.menu,
    //                     color: Colors.black,
    //                     size: 30,
    //                   ),
    //                   onPressed: () => {
    //                     controller.toggle(Direction.left),
    //                     // OR
    //                     // controller.open()
    //                   },
    //                 ),
    //               ),
    //             ),
    //             // Events & Search bar Starts
    //             PreferredSize(
    //               preferredSize: Size.fromHeight(80),
    //               child: Column(
    //                 children: <Widget>[
    //                   // Distance from ywca
    //                   // or else it will overlap
    //                   SizedBox(height: 80),
    //                   Center(
    //                     child: Text(
    //                       'User Profiles',
    //                       style: TextStyle(
    //                         fontSize: 26,
    //                         color: Color(0xff333333),
    //                         fontWeight: FontWeight.bold,
    //                         fontFamily: 'Montserrat',
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(height: 5),
    //                 ],
    //               ),
    //             ),
    //             // card view for the events
    //             Padding(
    //               padding: EdgeInsets.fromLTRB(0.0, 160.0, 0.0, 0.0),
    //               child: getHomePageBody(context),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  // Widget getHomePageBody(BuildContext context) {
  //   final _height = MediaQuery.of(context).size.height;
  //   final _width = MediaQuery.of(context).size.width;
  //   Widget searchData() {
  //     print('started');
  //     return ListView.builder(
  //       itemCount: snapshotData.docs.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return GestureDetector(
  //           onTap: () {
  //             // go to detail screen
  //             // uid = snapshotData.docs[index].get('uid')
  //             goToUserProfileDetails(
  //                 context,
  //                 snapshotData.docs[index].get('uid'),
  //                 snapshotData.docs[index].get('firstName'),
  //                 snapshotData.docs[index].get('lastName'),
  //                 snapshotData.docs[index].get('phoneNumber'),
  //                 snapshotData.docs[index].get('emailId'),
  //                 snapshotData.docs[index].get('address'),
  //                 snapshotData.docs[index].get('dateOfBirth'),
  //                 snapshotData.docs[index].get('memberRole'),
  //                 snapshotData.docs[index].get('gender'),
  //                 snapshotData.docs[index].get('nearestCenter'),
  //                 snapshotData.docs[index].get('placeOfWork'),
  //                 snapshotData.docs[index].get('profession'),
  //                 snapshotData.docs[index].get('interestInMembership'));
  //           },
  //           child: ListTile(
  //             leading: CircleAvatar(
  //               backgroundImage: NetworkImage(
  //                   'https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
  //             ),
  //             title: Padding(
  //               padding: EdgeInsets.fromLTRB(0, _width * 0.8, 0, 0.0),
  //               child: Text(
  //                 snapshotData.docs[index].get('firstName'),
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 24.0),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }

  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     appBar: AppBar(
  //       actions: [
  //         GetBuilder<DataController>(
  //           init: DataController(),
  //           builder: (val) {
  //             return IconButton(
  //                 icon: Icon(Icons.search),
  //                 color: Colors.black,
  //                 onPressed: () {
  //                   print("in pressed");
  //                   val.queryData(searchController.text).then((value) {
  //                     snapshotData = value;
  //                     setState(() {
  //                       isExecuted = true;
  //                     });
  //                   });
  //                 });
  //           },
  //         )
  //       ],
  //       title: TextField(
  //         style: TextStyle(color: Colors.black),
  //         decoration: InputDecoration(
  //             hintText: "Search User",
  //             hintStyle: TextStyle(color: Colors.black)),
  //         controller: searchController,
  //       ),
  //       backgroundColor: Colors.white,
  //     ),
  //     body: isExecuted
  //         ? searchData()
  //         : Container(
  //             child: Center(
  //             child: Text(
  //               'Search any user',
  //               style: TextStyle(color: Colors.black, fontSize: 16.0),
  //             ),
  //           )),
  //   );
  // }

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
