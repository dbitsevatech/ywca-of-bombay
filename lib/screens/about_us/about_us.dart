import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'become_member.dart';

import '../../drawers_constants/user_drawer.dart' as UserDrawer;
import '../../drawers_constants/admin_drawer.dart' as AdminDrawer;
import '../../models/User.dart';
import '../../widgets/blue_bubble_design.dart';
import '../../widgets/constants.dart';
import '../../widgets/alert_dialogs.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/zoom_image.dart';

// ignore: must_be_immutable
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final imagePathList = [
    'assets/images/about_us/Ywca_spotlight_1.jpg',
    'assets/images/about_us/Ywca_spotlight_2.jpg',
    'assets/images/about_us/Ywca_spotlight_3.jpg',
    'assets/images/about_us/Ywca_spotlight_4.jpg',
    'assets/images/about_us/Ywca_spotlight_5.jpg',
  ];
  final imageTitleList = [
    'Empowering Women',
    'Empowering through Vocations',
    'Empowering through Education',
    'Empowering the Underprivileged',
    'Empowering the Forgotten',
  ];

  final DrawerScaffoldController controller = DrawerScaffoldController();
  late int selectedMenuItemId;

  int _currentIndex = 0;

  var userInfo;

  @override
  void initState() {
    selectedMenuItemId = UserDrawer.menuWithIcon.items[0].id;
    userInfo = Provider.of<UserData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var role = userInfo.getmemberRole;
    final _height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => showExitAlertDialog(context),
      child: DrawerScaffold(
        // appBar: AppBar(), // green app bar
        drawers: [
          (role == "Admin")
              ? // ADMIN DRAWER
              SideDrawer(
                  percentage: 0.75, // main screen height proportion
                  headerView: AdminDrawer.header(context, userInfo),
                  footerView: AdminDrawer.footer(context, controller, userInfo),
                  color: successStoriesCardBgColor,
                  selectorColor: Colors.indigo[600],
                  menu: AdminDrawer.menuWithIcon,
                  animation: true,
                  selectedItemId: selectedMenuItemId,
                  onMenuItemSelected: (itemId) {
                    setState(() {
                      selectedMenuItemId = itemId;
                      AdminDrawer.selectedItem(context, itemId);
                    });
                  },
                )
              : // DRAWER FOR OTHER ROLES
              SideDrawer(
                  percentage: 0.75, // main screen height proportion
                  headerView: UserDrawer.header(context, userInfo),
                  footerView: UserDrawer.footer(context, controller, userInfo),
                  color: successStoriesCardBgColor,
                  selectorColor: Colors.indigo[600],
                  menu: UserDrawer.menuWithIcon,
                  animation: true,
                  selectedItemId: selectedMenuItemId,
                  onMenuItemSelected: (itemId) {
                    setState(() {
                      selectedMenuItemId = itemId;
                      UserDrawer.selectedItem(context, itemId);
                    });
                  },
                ),
        ],
        controller: controller,
        builder: (context, id) => SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
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
                            // widget.onMenuPressed,
                            controller.toggle(Direction.left),
                            // OR
                            // controller.open()
                          },
                        ),
                      ),
                    ),
                    // Events & Search bar Starts
                    Positioned(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: _height * 0.1),
                          child: Column(
                            children: [
                              Text(
                                'OUR STORY',
                                style: TextStyle(
                                  fontSize: 35,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'RacingSansOne',
                                  letterSpacing: 2.5,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(2.0, 3.0),
                                      blurRadius: 3.0,
                                      color: Color(0xff333333),
                                    ),
                                  ],
                                ),
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                  // height of whole carousel - including image and text
                                  // height: 290,
                                  height: _height * 0.28,
                                  autoPlay: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                ),
                                items: imagePathList.map((pathOfImage) {
                                  int index =
                                      imagePathList.indexOf(pathOfImage);
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Column(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Card(
                                                margin: EdgeInsets.only(
                                                  top: 10.0,
                                                  bottom: 10.0,
                                                ),
                                                elevation: 6.0,
                                                shadowColor: Colors.blueGrey,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(30.0),
                                                  ),
                                                  child: GestureDetector(
                                                    child: Image(
                                                      image: AssetImage(
                                                          pathOfImage),
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      height: 160,
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ZoomImageAsset(
                                                                  pathOfImage),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: _height * 0.01),
                                          Text(
                                            imageTitleList[index],
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat',
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'The Young Women\'s Christian Association (YWCA) was established in 1855, when the movement formed on prayer and service united together and adopted the Blue Triangle as its symbol that signifies the unity and completeness of body, mind and spirit.\n',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.25,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Text(
                            'The history of YWCA dates back to 1875 when the first local association was established in Mumbai. This was followed by the YWCA of India in the year 1896.\n',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.25,
                              fontFamily: 'Montserrat',
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'It is one of the oldest non-profit community service organizations for women In India, which is based on the biblical principle \"Love thy neighbour as thyself\".\n',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.25,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Text(
                            'The YWCA of Bombay is registered under the societies registration act, 1860 under no. 44 dated 06-08-1952 and of the Bombay public trust act, 1950 under no. F/388 (BOM.) dated 13-07-1953.',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.25,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          // ),
                          SizedBox(
                            height: _height * 0.010,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      text:
                                          "To learn more, visit our website:\n",
                                    ),
                                    TextSpan(
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      text: "www.ywcabombay.co.in\n",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          var url =
                                              "https://www.ywcabombay.co.in";
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                    ),
                                    TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      text: "\nFacebook page:\n",
                                    ),
                                    TextSpan(
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      text: "www.facebook.com/ywcabombay",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          var url =
                                              "https://www.facebook.com/ywcabombay";
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: _height * 0.015,
                          ),
                          if (role == "NonMember") ...[
                            GradientButton(
                              buttonText: 'Become a member today!',
                              screenHeight: _height,
                              onPressedFunction: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BecomeMemberScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                          SizedBox(height: _height * 0.020),
                        ],
                      ),
                    ),
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
