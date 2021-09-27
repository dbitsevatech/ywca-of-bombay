import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/view_profile.dart';
import '../services/auth_service.dart';
import '../widgets/constants.dart';

List<MenuItem> items = [
  MenuItem<int>(
    id: 0,
    title: 'About Us',
    prefix: Icon(Icons.info),
  ),
  MenuItem<int>(
    id: 1,
    title: 'Events',
    prefix: Icon(Icons.event),
  ),
  MenuItem<int>(
    id: 2,
    title: 'Initiatives',
    prefix: Icon(Icons.follow_the_signs_sharp),
  ),
  MenuItem<int>(
    id: 3,
    title: 'Success Stories',
    prefix: Icon(Icons.star),
  ),
  MenuItem<int>(
    id: 4,
    title: 'Contact Us',
    prefix: Icon(Icons.quick_contacts_mail),
  ),
  MenuItem<int>(
    id: 5,
    title: 'Analytics',
    prefix: Icon(Icons.insert_chart),
  ),
  MenuItem<int>(
    id: 6,
    title: 'Approval',
    prefix: Icon(Icons.verified_user),
  ),
  MenuItem<int>(
    id: 7,
    title: 'User Profiles',
    prefix: Icon(Icons.person),
  ),
];
final menu = Menu(
  items: items.map((e) => e.copyWith(prefix: null)).toList(),
);

final menuWithIcon = Menu(
  items: items,
);

void selectedItem(BuildContext context, int index) {
  // controller.toggle();
  Navigator.of(context).pop();

  switch (index) {
    case 0:
      Navigator.pushNamed(context, "/about_us");
      break;
    case 1:
      Navigator.pushNamed(context, "/admin_events");
      break;
    case 2:
      Navigator.pushNamed(context, "/initiatives");
      break;
    case 3:
      Navigator.pushNamed(context, "/success_stories");
      break;
    case 4:
      Navigator.pushNamed(context, "/contact_us");
      break;
    case 5:
      Navigator.pushNamed(context, "/analytics");
      break;
    case 6:
      Navigator.pushNamed(context, "/approval");
      break;
    case 7:
      Navigator.pushNamed(context, "/user_profiles");
      break;
  }
}

Widget header(BuildContext context, var userInfo) {
  // final DrawerScaffoldController controller = DrawerScaffoldController();
  return Container(
    width: MediaQuery.of(context).size.width * 0.7,
    child: Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Text(
          //   'YWCA Of Bombay',
          //   textAlign: TextAlign.left,
          //   style: TextStyle(
          //     fontSize: 22,
          //     color: Colors.black,
          //     fontFamily: 'LobsterTwo',
          //     fontStyle: FontStyle.italic,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // SizedBox(height: 5),
          // CircleAvatar(
          //   radius: 50.0,
          //   backgroundImage: AssetImage("assets/images/logo.png"),
          // ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image(
                image: AssetImage("assets/images/logo-with-text-round.png"),
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Welcome ' + userInfo.getfirstName,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          ElevatedButton.icon(
            icon: Icon(Icons.person),
            label: Text('View Profile'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed))
                    return primaryColor;
                  return secondaryColor; // Use the component's default.
                },
              ),
            ),
            onPressed: () {
              // TODO: Close drawer before opening this page OR after closing this page
              // controller.toggle();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

Widget footer(
    BuildContext context, DrawerScaffoldController controller, var userInfo) {
  final _height = MediaQuery.of(context).size.height;
  final _width = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.04,
    ),
    child: Column(
      children: [
        InkWell(
          onTap: () async => {
            // controller.toggle(),
            onLogoutPressed(context, userInfo),
          },
          child: Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.11,
              top: MediaQuery.of(context).size.height * 0.02,
              bottom: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Row(
              children: [
                Icon(Icons.logout, size: 20),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Logout',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Developed by DBIT SevaTech',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            // color: Colors.red,
            color: Color(0xff0056B4),
          ),
        ),
      ],
    ),
  );
}
