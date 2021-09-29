import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'analytics_details.dart';

import '../../../widgets/blue_bubble_design.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/alert_dialogs.dart';
import '../../../drawers_constants/admin_drawer.dart';
import '../../../models/User.dart';

// ignore: must_be_immutable
class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final Color scaffoldBackgroundColsor = const Color(0xFFFFDADA);
  final DrawerScaffoldController controller = DrawerScaffoldController();
  late int selectedMenuItemId;
  var userInfo;
  var responseList = [];
  ScrollController scrollController = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  double _height = 0;
  double _width = 0;

  List<Widget> itemsData = [];

  Future downloadData() async {
    await FirebaseFirestore.instance
        .collection("events")
        .orderBy('eventDate', descending: true)
        .get()
        .then((querySnapshot) async {
      querySnapshot.docs.forEach((result) {
        responseList.add({
          'eventName': result.data()["eventName"],
          'clicks': result.data()["eventClickCount"],
          'registrations': result.data()["eventRegisterCount"],
          'eventID': result.id,
          'date': DateFormat('dd MMM, yyyy EEE, hh:mm aaa')
              .format(result.data()["eventDate"].toDate()),
        });
      });
      // responseList.forEach((event) {
      //   FirebaseFirestore.instance
      //       .collection('eventRegistration')
      //       .where('eventID', isEqualTo: event["eventID"])
      //       .get()
      //       .then((querySnapshot) {
      //     event["registrations"] += querySnapshot.size;
      //   });
      //   FirebaseFirestore.instance
      //       .collection('eventClick')
      //       .where('eventID', isEqualTo: event["eventID"])
      //       .get()
      //       .then((querySnapshot) {
      //     event["clicks"] += querySnapshot.size;
      //   });
      // });
    });

    // await Future.delayed(const Duration(seconds: 2));
    getPostsData();
    // await Future.delayed(const Duration(seconds: 2));
    return responseList; // return your response
  }

  Future<void> getPostsData() async {
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnalyticsDetail(
                    eventDate: post["date"],
                    eventId: post["eventID"],
                    eventClicks: post["clicks"],
                    eventRegister: post["registrations"],
                    eventName: post["eventName"],
                  ),
                ));
          },
          child: Container(
            // height: 90,
            height: _height * 0.13,
            // width: 310,
            width: _width * 0.85,
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              // vertical: 34,
              vertical: _height * 0.035,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              // color: Colors.white,
              color: Color(0xFFDFFDFF),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(100),
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                  offset: Offset(
                    2.0, // Move to right
                    2.0, // Move to bottom
                  ),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 9,
                          child: Container(
                            padding: EdgeInsets.only(right: 10, bottom: 5),
                            child: AutoSizeText(
                              "${post["eventName"]}",
                              maxLines: 2,
                              minFontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Text(
                              "${post["registrations"]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                fontFamily: 'Montserrat',
                                color: Color(0xFF31326F),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Text(
                              "${post["clicks"]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                fontFamily: 'Montserrat',
                                color: Color(0xFFE05297),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              post["date"],
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
    if (!mounted) return;
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    userInfo = Provider.of<UserData>(context, listen: false);
    selectedMenuItemId = menuWithIcon.items[5].id;

    scrollController.addListener(() {
      double value = scrollController.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = scrollController.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _height = size.height;
    _width = size.width;

    return WillPopScope(
      onWillPop: () => showExitAlertDialog(context),
      child: DrawerScaffold(
        drawers: [
          SideDrawer(
            percentage: 0.75, // main screen height proportion
            headerView: header(context, userInfo),
            footerView: footer(context, controller, userInfo),
            color: successStoriesCardBgColor,
            selectorColor: Colors.indigo[600], menu: menuWithIcon,
            animation: true,
            selectedItemId: selectedMenuItemId,
            onMenuItemSelected: (itemId) {
              setState(() {
                selectedMenuItemId = itemId;
                selectedItem(context, itemId);
              });
            },
          ),
        ],
        controller: controller,
        builder: (context, id) => SafeArea(
          child: Scaffold(
            // backgroundColor: Color(0xFFFFDADA),
            body: Container(
              height: size.height,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      // top-left corner intersecting circles design
                      MainPageBlueBubbleDesign(),
                      Positioned(
                        child: AppBar(
                          centerTitle: true,
                          title: Text(
                            "YWCA OF BOMBAY",
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0,
                              color: Colors.black87,
                            ),
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          leading: IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () => {
                              controller.toggle(Direction.left),
                              // OR
                              // controller.open()
                            },
                          ),
                        ),
                      ),
                      PreferredSize(
                        preferredSize: Size.fromHeight(100),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              // Distance from ywca
                              // or else it will overlap
                              SizedBox(height: 70),
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyText2,
                                  children: [
                                    TextSpan(
                                      text: 'Analytics',
                                      style: TextStyle(
                                        fontSize: 32,
                                        color: Color(0xff333333),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Spacer(flex: 3),
                        Container(
                          child: Text(
                            "Title",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        Spacer(flex: 4),
                        Container(
                          child: Text(
                            "Registered",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        Spacer(flex: 1),
                        Container(
                          child: Text(
                            "Clicked",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        Spacer(flex: 2),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future:
                          downloadData(), // function where you call your api
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        // AsyncSnapshot<Your object type>
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Text(
                              'Please wait its loading...',
                            ),
                          );
                        } else {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            // getPostsData();

                            return ListView.builder(
                              // controller: scrollController,
                              itemCount: itemsData.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                double scale = 1.0;
                                if (topContainer > 0.5) {
                                  scale = index + 0.5 - topContainer;
                                  if (scale < 0) {
                                    scale = 0;
                                  } else if (scale > 1) {
                                    scale = 1;
                                  }
                                }
                                return Opacity(
                                  opacity: scale,
                                  child: Transform(
                                    transform: Matrix4.identity()
                                      ..scale(scale, scale),
                                    alignment: Alignment.bottomCenter,
                                    child: Align(
                                      heightFactor: 0.7,
                                      alignment: Alignment.topCenter,
                                      child: itemsData[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
