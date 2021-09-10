import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'screens/about_us/about_us.dart';
import 'screens/admin/events/admin_events.dart';
import 'screens/admin/analytics/analytics.dart';
import 'screens/admin/approval/approval.dart';
import 'screens/authentication/login.dart';
import 'screens/authentication/register.dart';
import 'screens/contact_us/contact_us.dart';
import 'screens/events/user_events.dart';
import 'screens/initiatives/initiatives.dart';
import 'screens/success_stories/success_stories.dart';
import 'services/auth_service.dart';
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
    // return OnboardingScreen();
    // return Events();
    // return LoginScreen();
    return AboutUs();
    // return HomeController();
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.authStateChanges,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Events() : LoginScreen();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
