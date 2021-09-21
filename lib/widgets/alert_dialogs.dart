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

    Future<dynamic> savePressed(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'You have been successfully registered for this event!'),
          actions: <Widget>[
            TextButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

Future<void> showRegisterAlertDialog(
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
                        savePressed(context);
                        // Navigator.of(context).pop();
                        // Navigator.of(context).pop();
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
Future<void> showAlreadyRegisterAlertDialog(
    context
    ) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('You are already registered to this event!'),

        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK!',
              ),
            ),
          ),
        ],
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
        print("already added");
      } else {
        print("adding");
        // incrementing eventRegisterClick in events
        final DocumentReference docRef = FirebaseFirestore
        .instance
        .collection("events")
        .doc(eventID);
        docRef.update({"eventRegisterCount": FieldValue.increment(1)});
        FirebaseFirestore.instance
            .collection('eventRegistration')
            .add({'eventID': eventID, 'userID': userID});
      }
    },
  );
}
