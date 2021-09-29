import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/alert_dialogs.dart';

import '../../drawers_constants/user_drawer.dart' as UserDrawer;
import '../../drawers_constants/admin_drawer.dart' as AdminDrawer;
import '../../models/Initiative.dart';
import '../../models/User.dart';
import '../../widgets/blue_bubble_design.dart';
import '../../widgets/constants.dart';
import '../../widgets/initiative_card.dart';

// ignore: must_be_immutable
class Initiatives extends StatefulWidget {
  @override
  _InitiativesState createState() => _InitiativesState();
}

class _InitiativesState extends State<Initiatives> {
  final List<Initiative> _allInitiatives = Initiative.allInitiatives();

  final DrawerScaffoldController controller = DrawerScaffoldController();
  late int selectedMenuItemId;
  var userInfo;

  @override
  void initState() {
    selectedMenuItemId = UserDrawer.menuWithIcon.items[2].id;
    userInfo = Provider.of<UserData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var role =
        userInfo.getmemberRole; // to identify if user is admin or other role
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
                  // circle design
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
                    PreferredSize(
                      preferredSize: Size.fromHeight(100),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            // Distance from ywca
                            // or else it will overlap
                            SizedBox(height: _height * 0.1),
                            Text(
                              'Initiatives ',
                              style: TextStyle(
                                fontSize: 26,
                                color: Color(0xff333333),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            SizedBox(height: _height * 0.02),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                getAllInitiatives(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getAllInitiatives(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Expanded(
      child: Container(
        height: _height,
        width: double.infinity, // max width possible
        child: ListView.builder(
          itemCount: _allInitiatives.length,
          // itemCount: snapshot.data.documents.length + 1,
          itemBuilder: (BuildContext context, int index) {
            return buildInitiativeCard(context, index);
          },
        ),
      ),
    );
  }
}
