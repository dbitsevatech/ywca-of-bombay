import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/about_us.dart';
import '../screens/admin/analytics/analytics.dart';
import '../screens/admin/approval/approval.dart';
import '../screens/class_builder.dart';
import '../widgets/constants.dart';
import '../screens/contact_us/contact_us.dart';
import '../screens/events/events.dart';
import '../screens/home.dart';
import '../screens/initiatives/initiatives.dart';
import '../screens/authentication/login.dart';
import '../screens/success_stories/success_stories.dart';
import '../models/user.dart';
import '../screens/view_profile.dart';

class AdminMainWidget extends StatefulWidget {
  AdminMainWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AdminMainWidgetState createState() => _AdminMainWidgetState();
}

class _AdminMainWidgetState extends State<AdminMainWidget>
    with TickerProviderStateMixin {
  KFDrawerController _drawerController;
  var userInfo;
  @override
  void initState() {
    userInfo = Provider.of<UserData>(context, listen: false);
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('Home'),
      items: [
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.home),
              SizedBox(width: 10),
              Text(
                'Home',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: Home(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.details),
              SizedBox(width: 10),
              Text(
                'About Us',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: AboutUs(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.event),
              SizedBox(width: 10),
              Text(
                'Events',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: Events(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.follow_the_signs_sharp),
              SizedBox(width: 10),
              Text(
                'Initiatives',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: Initiatives(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.star),
              SizedBox(width: 10),
              Text(
                'Success Stories',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: SuccessStories(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.quick_contacts_mail),
              SizedBox(width: 10),
              Text(
                'Contact Us',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: ContactUs(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.quick_contacts_mail),
              SizedBox(width: 10),
              Text(
                'Analytics',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: AnalyticsScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.quick_contacts_mail),
              SizedBox(width: 10),
              Text(
                'Approval',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: ApprovalScreen(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // in Moto G5s Plus
      // A RenderFlex overflowed by 90 pixels on the bottom.
      // The relevant error-causing widget was
      // KFDrawer
      // lib\widgets\drawer.dart:119
      body: KFDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 10, 80, 0),
            width: MediaQuery.of(context).size.width * 0.8,
            // Bug: on Redmi 8/Moto G5s Plus
            // A RenderFlex overflowed by 2.0/ 27.0 pixels on the right.
            // The relevant error-causing widget was
            // Row
            // lib\widgets\drawer.dart:88
            child: Row(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text('YWCA OF BOMBAY',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 15),
                    Text('MENU',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                        "https://content.jdmagicbox.com/comp/mumbai/54/022p4700154/catalogue/ywca-of-bombay-andheri-west-mumbai-hostels-p2eb4p7v56.jpg?clr=666600",
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Welcome, ' +
                          Provider.of<UserData>(context, listen: false)
                              .getfirstName,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton.icon(
                      icon: Icon(Icons.person),
                      label: Text('View Profile'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return primaryColor;
                            return secondaryColor; // Use the component's default.
                          },
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewProfileScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                )
              ],
            ),
          ),
        ),
        footer: KFDrawerItem(
          text: Text(
            'LOGOUT',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
          icon: Icon(
            Icons.logout,
            color: Colors.black,
            size: 22,
          ),
          onPressed: () async {
            userInfo.updateAfterAuth(
                "", "", "", DateTime.now(), "", "", "", "", "", "", "");
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false);
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.3, 0.8, 0.9],
            colors: [
              Colors.white,
              Colors.white,
              primaryColor,
              secondaryColor,
            ],
          ),
        ),
      ),
    );
  }
}
