// https://github.com/davefaliskie/travel_treasury/tree/episode_20/lib
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:ywcaofbombay/models/User.dart';
// import 'package:flutter/material.dart';

import '../screens/authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<String> get authStateChanges =>
      _firebaseAuth.authStateChanges().map((User? user) => user!.uid);

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
              userInfo.updateAfterAuth("", "", "", DateTime.now(), "", "", "",
                  "", "", "", "", "", "");
              // sharepreferences instance
              final prefsMember = await SharedPreferences.getInstance();
              // setting the value of member_popup = false after logout
              await prefsMember.setBool('member_popup', false);
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
