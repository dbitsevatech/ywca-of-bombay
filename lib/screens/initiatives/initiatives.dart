import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../drawers_constants/user_drawer.dart';
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
    selectedMenuItemId = menuWithIcon.items[2].id;
    userInfo = Provider.of<UserData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("item: $selectedMenuItemId");
    final _height = MediaQuery.of(context).size.height;
    return DrawerScaffold(
      // appBar: AppBar(), // green app bar
      drawers: [
        SideDrawer(
          percentage: 0.75, // main screen height proportion
          headerView: header(context, userInfo),
          footerView: footer(context, controller, userInfo),
          color: successStoriesCardBgColor,
          selectorColor: Colors.red,
          menu: menuWithIcon,
          animation: true,
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (itemId) {
            setState(() {
              selectedMenuItemId = itemId;
              selectedItem(context, itemId);
            });
          },
        )
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
    );
  }

  // TODO: Initiatives on Firebase? add firebase code?

  // Stream<QuerySnapshot> getInitiativesStreamSnapshots(
  //     BuildContext context) async* {
  //   yield* FirebaseFirestore.instance.collection('userData').doc(uid).collection('trips').orderBy('startDate').snapshots();
  // }

  // Widget getAllInitiatives(BuildContext context) {
  //   return Expanded(
  //     child: StreamBuilder(
  //       stream: getInitiativesStreamSnapshots(context),
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) return const Text("Loading...");
  //         return ListView.builder(
  //           itemCount: _allInitiatives.length,
  //           // itemCount: snapshot.data.documents.length + 1,
  //           itemBuilder: (BuildContext context, int index) {
  //             return _buildInitiativeCard(context, index);
  //           },);},),);
  // }

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
