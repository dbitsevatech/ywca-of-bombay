import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationsManager extends StatefulWidget {
  PushNotificationsManager() : super();

  final String title = 'Firebase Messaging Demo';

  @override
  _PushNotificationsManagerState createState() =>
      _PushNotificationsManagerState();
}

class _PushNotificationsManagerState extends State<PushNotificationsManager> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // getToken
  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("device token: $deviceToken");
    });
  }

  _configureFirebaseListerners() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print('onMessage: $message');
    //     _setMessage(message);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print('onMessage: $message');
    //     _setMessage(message);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print('onMessage: $message');
    //     _setMessage(message);
    //   }
    // );
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification notification = message.notification;
//       showNotification(notification);
// });

// foreground notifications
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Message data: $message');
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {
      print("onBackgroundMessage: $message");
    });
  }

  @override
  void initState() {
    super.initState();
    _configureFirebaseListerners();
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: ListView.builder(
      //   itemCount: null == _messages ? 0 : _messages.length,
      //   itemBuilder: (context, index){
      //     return Card(
      //       child: Padding(
      //       padding: EdgeInsets.all(15.0),
      //       child: Text(
      //         _messages[index].message,
      //         style: TextStyle(
      //           fontSize: 16,
      //           color: Colors.black,
      //         )
      //       ),
      //       ),
      //     );
      //   },
      // )
    );
  }
}

// class Message {
//   String title;
//   String body;
//   String message;
//   Message(title, body, message) {
//     this.title = title;
//     this.body = body;
//     this.message = message;
//   }
// }