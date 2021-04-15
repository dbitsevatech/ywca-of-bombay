import 'package:ywcaofbombay/screens/authentication/login.dart';
import 'package:ywcaofbombay/screens/class_builder.dart';
import 'package:ywcaofbombay/screens/contact_us/contact_us.dart';
import 'package:ywcaofbombay/screens/home.dart';
import 'package:ywcaofbombay/screens/about_us.dart';
import 'package:ywcaofbombay/screens/events/events.dart';
import 'package:ywcaofbombay/screens/initiatives/initiatives.dart';
import 'package:ywcaofbombay/screens/success_stories.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kf_drawer/kf_drawer.dart';

class MainWidget extends StatefulWidget {
  MainWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('Home'),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('Home',
              style: TextStyle(color: Colors.black87, fontSize: 22)),
          page: Home(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'About us',
            style: TextStyle(color: Colors.black87, fontSize: 22),
          ),
          page: AboutUs(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Events',
            style: TextStyle(color: Colors.black87, fontSize: 22),
          ),
          page: Events(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Initiatives',
            style: TextStyle(color: Colors.black87, fontSize: 22),
          ),
          page: Initiatives(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Success Stories',
            style: TextStyle(color: Colors.black87, fontSize: 22),
          ),
          page: SuccessStories(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Contact Us',
            style: TextStyle(color: Colors.black87, fontSize: 22),
          ),
          page: ContactUs(),
        )
        // TODO: Show analytics and admin approval option, IF USER IS ADMIN
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 10, 80, 0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: <Widget>[
                    new Text('YWCA OF BOMBAY',
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold)),
                    new SizedBox(height: 15),
                    new Text('MENU',
                        style: new TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    new SizedBox(height: 10),
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                        // TODO: Add user image
                        "https://content.jdmagicbox.com/comp/mumbai/54/022p4700154/catalogue/ywca-of-bombay-andheri-west-mumbai-hostels-p2eb4p7v56.jpg?clr=666600",
                      ),
                    ),
                    new SizedBox(height: 15),
                    new Text(
                      // TODO: Add user name
                      'Welcome, user',
                      style: new TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    new SizedBox(height: 10),
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
              // Colors.blue[100],
              Color(0xff49DEE8),
              // Colors.blue[200],
              Color(0xff49DEE8),
            ],
          ),
        ),
      ),
    );
  }
}
