import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auth/authentication/register.dart';
import 'package:auth/pages/class_builder.dart';

void main() async {
  ClassBuilder.registerClasses();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SignUp();
  }
}
