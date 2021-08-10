import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';

import '../widgets/constants.dart';
import '../screens/view_profile.dart';
import '../services/auth_service.dart';

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
      Navigator.pushNamed(context, "/events");
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
  }
}

Widget header(BuildContext context, var userInfo) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.7,
    child: Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'YWCA Of Bombay',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontFamily: 'LobsterTwo',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'MENU',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          CircleAvatar(
            radius: 50.0,
            backgroundImage: NetworkImage(
              "https://content.jdmagicbox.com/comp/mumbai/54/022p4700154/catalogue/ywca-of-bombay-andheri-west-mumbai-hostels-p2eb4p7v56.jpg?clr=666600",
            ),
          ),
          SizedBox(height: 5),
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
  return Padding(
    padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.04,
    ),
    child: InkWell(
      onTap: () async => {
        // controller.toggle(),

        // function from auth_service.dart
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
  );
}
