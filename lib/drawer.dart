import 'package:auth/pages/class_builder.dart';
import 'package:auth/pages/contact_us.dart';
import 'package:auth/pages/home.dart';
import 'package:auth/pages/about_us.dart';
import 'package:auth/pages/events.dart';
import 'package:auth/pages/initiatives.dart';
import 'package:auth/pages/success_stories.dart';
import 'package:auth/authentication/register.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kf_drawer/kf_drawer.dart';

// void main() {
//   ClassBuilder.registerClasses();
//   runApp(MyApp2());
// }

// class MyApp2 extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: MainWidget(),
//     );
//   }
// }

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
                    new Text('YMCA OF BOMBAY',
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

                    /*to do
                    image has to be added 
                    Image(image: null) */
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
                        MaterialPageRoute(builder: (context) => SignUp()),
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
              Colors.blue[100],
              Colors.blue[200],
            ],
          ),
        ),
      ),
    );
  }
}
