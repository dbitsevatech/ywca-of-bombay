import 'package:flutter/cupertino.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

import '../../../widgets/blue_bubble_design.dart';
import '../../../widgets/constants.dart';
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

  ScrollController scrollController = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = DATA;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(
        Container(
          height: 85,
          width: 310,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 34),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 146,
                      height: 39,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          post["name"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 42,
                      height: 41,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          "${post["registrations"]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Color(0xFF31326F),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 38,
                    ),
                    Container(
                      width: 42,
                      height: 41,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          "${post["clicks"]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Color(0xFFE05297),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      width: 101,
                      height: 13,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          post["date"],
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF555555),
                          ),
                        ),
                      ),
                    )
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
    userInfo = Provider.of<UserData>(context, listen: false);
    selectedMenuItemId = menuWithIcon.items[5].id;
    getPostsData();
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
    print("item: $selectedMenuItemId");
    return DrawerScaffold(
      drawers: [
        SideDrawer(
          percentage: 0.75, // main screen height proportion
          headerView: header(context, userInfo),
          footerView: footer(context, controller, userInfo),
          color: successStoriesCardBgColor,
          selectorColor: Colors.red, menu: menuWithIcon,
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
          backgroundColor: Color(0xFFFFDADA),
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
                            fontFamily: 'LobsterTwo',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
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
                  child: ListView.builder(
                    controller: scrollController,
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
        ),
      ),
    );
  }
}
