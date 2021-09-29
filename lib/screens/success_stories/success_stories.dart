import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/blue_bubble_design.dart';
import 'constants.dart';
import '../../drawers_constants/user_drawer.dart' as UserDrawer;
import '../../drawers_constants/admin_drawer.dart' as AdminDrawer;
import '../../models/User.dart';
import '../../widgets/constants.dart';
import '../../widgets/alert_dialogs.dart';

// ignore: must_be_immutable
class SuccessStories extends StatefulWidget {
  @override
  _SuccessStoriesState createState() => _SuccessStoriesState();
}

class _SuccessStoriesState extends State<SuccessStories> {
  final DrawerScaffoldController controller = DrawerScaffoldController();
  final pageController = PageController(viewportFraction: 0.95, keepPage: true);
  late int selectedMenuItemId;
  var userInfo;

  @override
  void initState() {
    // REDUNDANT
    // if (userInfo.getmemberRole == "Admin") {
    //   selectedMenuItemId = AdminDrawer.menuWithIcon.items[3].id;
    // } else {
    //   selectedMenuItemId = UserDrawer.menuWithIcon.items[3].id;
    // }
    selectedMenuItemId = UserDrawer.menuWithIcon.items[3].id;
    userInfo = Provider.of<UserData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var role =
        userInfo.getmemberRole; // to identify if user is admin or other role
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final pages = List.generate(
      titles.length,
      (i) => cardWid(
        images[i],
        titles[i],
        detailText[i],
        _height,
        _width,
      ),
    );

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
                  // circle design

                  children: <Widget>[
                    MainPageBlueBubbleDesign(),
                    // Positioned(
                    //   child: Image.asset("assets/images/circle-design.png"),
                    // ),
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
                    //Title start
                    Padding(
                      padding: EdgeInsets.only(top: _height * 0.12),
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'Success Stories',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff333647),
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Title end
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      // height: 540,
                      height: _height * 0.69,
                      child: PageView.builder(
                        controller: pageController,
                        // itemCount: pages.length,
                        itemBuilder: (_, index) {
                          return pages[index % pages.length];
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: pages.length,
                        effect: ScrollingDotsEffect(
                          activeStrokeWidth: 2,
                          activeDotScale: 1.3,
                          maxVisibleDots: 7,
                          radius: 8,
                          spacing: 10,
                          dotHeight: 12,
                          dotWidth: 12,
                          activeDotColor: Color.fromRGBO(0, 0, 0, 0.8),
                          dotColor: Color.fromRGBO(0, 0, 0, 0.3),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardWid(
    String image,
    String title,
    String detailText,
    double _height,
    double _width,
  ) {
    //  card start
    return Container(
      margin: EdgeInsets.only(
        left: _width * 0.07,
        right: _width * 0.07,
        bottom: _height * 0.005,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFCDF1EF)),
        color: successStoriesCardBgColor,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      // height: 540, //540 init
      // width: 360,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //    image
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(
                top: _height * 0.020,
                bottom: _height * 0.010,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(120.0),
                child: Image(
                  image: AssetImage(image),
                  // fit: BoxFit.contain,
                  // height: 175,
                  // width: 175,
                ),
              ),
            ),
          ),
          //  image end
          //  card Title
          Text(
            title,
            // 'A Slice Of Support',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          //  card Title end

          // card info
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.only(
                left: _width * 0.05,
                right: _width * 0.05,
                top: _height * 0.005,
                bottom: _height * 0.015,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  detailText,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 18,
                    height: 1.3,
                  ),
                ),
              ),
            ),
          ),
          //  end card info
        ],
      ),
    );
  }
}
