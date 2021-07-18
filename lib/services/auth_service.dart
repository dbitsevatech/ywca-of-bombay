// https://github.com/davefaliskie/travel_treasury/tree/episode_20/lib
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:ywcaofbombay/models/User.dart';
// import 'package:flutter/material.dart';

import '../screens/authentication/login.dart';
// import '../screens/authentication/login_otp.dart';
// import '../screens/authentication/register.dart';
// import '../screens/authentication/register_otp.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<String> get authStateChanges =>
      _firebaseAuth.authStateChanges().map((User? user) => user!.uid);

  // // Email & Password Sign Up
  // Future<String> createUserWithEmailAndPassword(
  //     String email, String password, String name) async {
  //   final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );

  //   // Update the username
  //   var userUpdateInfo = UserUpdateInfo();
  //   userUpdateInfo.displayName = name;
  //   await currentUser.updateProfile(userUpdateInfo);
  //   await currentUser.reload();
  //   return currentUser.uid;
  // }

  // // Email & Password Sign In
  // Future<String> signInWithEmailAndPassword(
  //     String email, String password) async {
  //   return (await _firebaseAuth.signInWithEmailAndPassword(
  //           email: email, password: password))
  //       .uid;
  // }

  // Phone Auth

  // check if user already registered or not
  Future<bool> userExists(String phoneNumber) async {
    print("userExists function called");
    var checkuser = await _firebaseFirestore
        .collection('users')
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get();
    print("returned bool");
    return (checkuser.docs.length == 1);
  }

  // Sign Out
  signOut() {
    return _firebaseAuth.signOut();
  }
}

// show dialog for logout press
// Future<bool> _onLogoutPressed(BuildContext context, UserData userInfo) {
onLogoutPressed(context, userInfo) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Do you really want to Log Out ?'),
        actions: <Widget>[
          TextButton(
            child: Text('NO'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text('YES'),
            onPressed: () async {
              userInfo.updateAfterAuth(
                  "", "", "", DateTime.now(), "", "", "", "", "", "", "", "");
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            },
          ),
        ],
      );
    },
  );
}
