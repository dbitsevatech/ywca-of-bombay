import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'services/auth_service.dart';
import 'screens/class_builder.dart';
import 'widgets/drawer.dart';
import 'screens/authentication/login.dart';
import 'screens/onboarding.dart';
import 'screens/authentication/register.dart';
import 'models/user.dart';

void main() async {
  ClassBuilder.registerClasses();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

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
    return OnboardingScreen();
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
          return signedIn ? MainWidget() : LoginScreen();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
