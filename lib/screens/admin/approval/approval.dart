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
                      "\Name: ${post["firstName"]} ${post["lastName"]}",
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
                      "\Contact Number: ${post["phoneNumber"]}",
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
                      "\Email ID: ${post["emailId"]}",
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
                      "\Nearest YWCA center: ${post["nearestCenter"]}",
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
                      "\Institute/Organisation: ${post["placeOfWork"]}",
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
                      "\Profession: ${post["profession"]}",
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
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
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
                          // vertical: 3,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                            width: 85,
                            height: 24,
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
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
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 21, top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
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
                        child: ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                            width: 85,
                            height: 24,
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                            child: Text(
                              "Reject",
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
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
      child: Scaffold(
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
                    preferredSize: Size.fromHeight(80),
                    child: Column(
                      children: <Widget>[
                        // Distance from ywca
                        // or else it will overlap
                        SizedBox(height: 80),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText2,
                            children: [
                              TextSpan(
                                text: 'Approval ',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: Icon(
                                    Icons.notification_important,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Search by name",
                            hintStyle: TextStyle(fontFamily: 'Montserrat'),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            suffixIcon: Icon(
                              Icons.mic,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ],
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
                          heightFactor: 0.8,
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
      ),
    );
  }
}
