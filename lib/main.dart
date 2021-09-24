import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ywcaofbombay/screens/admin/user_profiles/edit_user_profile.dart';
import 'package:ywcaofbombay/screens/admin/user_profiles/user_profile_details.dart';
import 'package:ywcaofbombay/screens/edit_profile.dart';
import 'screens/about_us/about_us.dart';
import 'screens/admin/events/admin_events.dart';
import 'screens/admin/analytics/analytics.dart';
import 'screens/admin/approval/approval.dart';
import 'screens/authentication/login.dart';
import 'screens/onboarding.dart';
import 'screens/authentication/register.dart';
import 'screens/contact_us/contact_us.dart';
import 'screens/events/user_events.dart';
import 'screens/initiatives/initiatives.dart';
import 'screens/success_stories/success_stories.dart';
import 'services/class_builder.dart';
import 'models/User.dart';

void main() async {
  ClassBuilder.registerClasses();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(fontFamily: 'Montserrat'),
        home: MyApp(),
        routes: <String, WidgetBuilder>{
          // '/': (BuildContext context) => MyApp(),
          '/register': (BuildContext context) => RegisterScreen(),
          '/login': (BuildContext context) => LoginScreen(),
          "/events": (context) => Events(),
          "/admin_events": (context) => AdminEvents(),
          "/initiatives": (context) => Initiatives(),
          "/success_stories": (context) => SuccessStories(),
          "/about_us": (context) => AboutUs(),
          "/contact_us": (context) => ContactUs(),
          "/analytics": (context) => AnalyticsScreen(),
          "/approval": (context) => ApprovalScreen(),
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xff49DEE8),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Splash();
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    var userInfo = Provider.of<UserData>(context, listen: false);
    var userdata;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        print(currentUser.uid);
        var checkuser = await FirebaseFirestore.instance
            .collection('users')
            .where("uid", isEqualTo: currentUser.uid)
            .get();
        if (checkuser.docs.length == 1) {
          userdata = checkuser.docs[0].data();
          userInfo.updateAfterAuth(
              userdata['uid'],
              userdata['firstName'],
              userdata['lastName'],
              userdata['dateOfBirth'].toDate(),
              userdata['emailId'],
              userdata['phoneNumber'],
              userdata['gender'],
              userdata['profession'],
              userdata['placeOfWork'],
              userdata['nearestCenter'],
              userdata['interestInMembership'],
              userdata['memberRole'],
              userdata['address']);
        }
        if (userdata['memberRole'] == "Admin") {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new AdminEvents()));
        } else {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new Events()));
        }
      } else {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new LoginScreen()));
      }
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new OnboardingScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
    );
  }
}
