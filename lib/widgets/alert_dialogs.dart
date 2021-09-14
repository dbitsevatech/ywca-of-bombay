import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

Future<bool> showExitAlertDialog(context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Do you want to exit?"),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print('yes selected');
                        exit(0);
                      },
                      child: Text("Yes"),
                      style: ElevatedButton.styleFrom(
                        primary: secondaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print('no selected');
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "No",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<bool> showRegisterAlertDialog(
  context,
  String eventID,
  String eventName,
  FirebaseAuth auth,
) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Confirm registration?"),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print('yes selected');
                        // onRegister for counting registration by the user
                        insertIntoOnRegistration(eventID, eventName, auth);
                        Navigator.of(context).pop();
                      },
                      child: Text("Yes"),
                      style: ElevatedButton.styleFrom(
                        primary: secondaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print('no selected');
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "No",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

// onRegister for counting registration by the user
void insertIntoOnRegistration(
    String eventID, String eventName, FirebaseAuth auth) async {
  final User? user = auth.currentUser;
  final userID = user?.uid;
  FirebaseFirestore.instance
      .collection('eventRegistration')
      .where('eventID', isEqualTo: eventID)
      .where('userID', isEqualTo: userID)
      .get()
      .then(
    (checkSnapshot) {
      if (checkSnapshot.size > 0) {
      } else {
        FirebaseFirestore.instance
            .collection('eventRegistration')
            .add({'eventID': eventID, 'userID': userID});
      }
    },
  );
}
