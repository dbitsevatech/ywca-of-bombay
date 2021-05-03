import 'package:flutter/cupertino.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

import '../../../widgets/blue_bubble_design.dart';

// ignore: must_be_immutable
class ApprovalScreen extends KFDrawerContent {
  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = DATA;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(
        Container(
          height: 182,
          width: 336,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 34),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF49DEE8),
                Colors.white,
              ],
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 0, top: 10),
                  width: 298,
                  height: 15,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "\Name: ${post["name"]}",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 0),
                  width: 298,
                  height: 15,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "\Contact Number: ${post["num"]}",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 0),
                  width: 298,
                  height: 15,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "\Email ID: ${post["email"]}",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 0),
                  width: 298,
                  height: 15,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "\Nearest YWCA center: ${post["center"]}",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 0),
                  width: 298,
                  height: 15,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "\Institute/Organisation: ${post["ins"]}",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 0),
                  width: 298,
                  height: 15,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "\Profession: ${post["prof"]}",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 63, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.green,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(100),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        width: 85,
                        height: 24,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 3),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              "Approve",
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.red,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(100),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        width: 85,
                        height: 24,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0.0,
                            vertical: 3,
                          ),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              "Reject",
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ])
              ],
            ),
          ),
        ),
      );
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // final double categoryHeight = size.height * 0.30;
    return SafeArea(
      child: Container(
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
                      "YWCA Of Bombay",
                      style: TextStyle(
                        fontFamily: 'LilyScriptOne',
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
                      onPressed: widget.onMenuPressed,
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
                                text: 'Approval',
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
            Expanded(
              child: ListView.builder(
                controller: controller,
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
                      transform: Matrix4.identity()..scale(scale, scale),
                      alignment: Alignment.bottomCenter,
                      child: Align(
                        heightFactor: 0.7,
                        alignment: Alignment.topCenter,
                        child: itemsData[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
