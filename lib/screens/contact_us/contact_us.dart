import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/alert_dialogs.dart';

import 'constants.dart';
import '../../drawers_constants/user_drawer.dart' as UserDrawer;
import '../../drawers_constants/admin_drawer.dart' as AdminDrawer;
import '../../models/User.dart';
import '../../widgets/blue_bubble_design.dart';
import '../../widgets/constants.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

late double _height;
late double _width;

// ignore: must_be_immutable
class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final DrawerScaffoldController controller = DrawerScaffoldController();
  late int selectedMenuItemId;
  String emailId = "";
  String phoneNo = "8452930878";

  var userInfo;

  @override
  void initState() {
    selectedMenuItemId = UserDrawer.menuWithIcon.items[4].id;
    userInfo = Provider.of<UserData>(context, listen: false);
    super.initState();
  }

  void sendEmail(BuildContext context, String emailId) async {
    print('in send email');
    print(emailId);
    var apps = await OpenMailApp.getMailApps();
    emailId = emailId;
    if (apps.isEmpty) {
      showNoMailAppsDialog(context);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return MailAppPickerDialog(
            mailApps: apps,
            emailContent: EmailContent(
              to: [
                emailId,
              ],
              // subject: 'Hello!',
              // body: 'How are you doing?',
              // cc: ['user2@domain.com', 'user3@domain.com'],
              // bcc: ['boss@domain.com'],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var role =
        userInfo.getmemberRole; // to identify if user is admin or other role
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    print("item: $selectedMenuItemId");
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
                            SizedBox(height: 70),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyText2,
                                children: [
                                  TextSpan(
                                    text: 'Contact Us',
                                    style: TextStyle(
                                      fontSize: 26,
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 1.5,
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
                  child: DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        // title: Text(''),
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(10),
                          child: Container(
                            child: TabBar(
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                              labelStyle: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                              unselectedLabelColor: Colors.black54,
                              labelColor: Colors.black,
                              indicatorColor: secondaryColor,
                              indicatorWeight: 2.5,
                              tabs: [
                                Container(
                                  height: 20.0,
                                  width: 120.0,
                                  child: Tab(text: 'OFFICES'),
                                ),
                                Container(
                                  height: 20.0,
                                  width: 120.0,
                                  child: Tab(text: 'HOSTELS'),
                                ),
                                Container(
                                  height: 20.0,
                                  width: 120.0,
                                  child: Tab(text: 'GUEST HOUSES'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      body: TabBarView(
                        children: <Widget>[
                          officesTab(),
                          hostelsTab(),
                          guestHousesTab(),
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

  Widget centerCard(
    String title,
    String address,
    String emailId,
    String phoneNo, {
    String? emailId2,
    String? phoneNo2,
  }) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: contactUsBorderColor),
          color: contactUsCardColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        height: _height * 0.18,
        width: _width * 0.80,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                // text: "ANDHERI \n ",
                text: title,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'CM Sans Serif',
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: address,
                    // ' Asha Kiran,\n 53,J.P. Road,\nAndheri (W)\n Mumbai-400058\n Email:ywcaandheri@rediffmail.com\n Ph:022-26702831 / 022-26702872',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.5,
                    ),
                  ),
                  TextSpan(
                    text: 'Email ID: ',
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () => {
                            print(emailId),
                            sendEmail(context, emailId),
                          },
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 11.5,
                    ),
                  ),
                  TextSpan(
                    text: emailId,
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () => {
                            print(emailId),
                            sendEmail(context, emailId),
                          },
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.blue,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.5,
                    ),
                  ),
                  if (emailId2 != null) ...[
                    TextSpan(
                      text: "              /$emailId2",
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () => {
                              print(emailId2),
                              sendEmail(context, emailId2),
                            },
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.blue,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                  TextSpan(
                    text: 'Phone No: ',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 11.5,
                    ),
                  ),
                  TextSpan(
                    text: phoneNo,
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () => {
                            FlutterPhoneDirectCaller.callNumber(phoneNo),
                          },
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.blue,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.5,
                    ),
                  ),
                  if (phoneNo2 != null) ...[
                    TextSpan(
                      text: " / $phoneNo2",
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () => {
                              FlutterPhoneDirectCaller.callNumber(phoneNo2),
                            },
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.blue,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget officesTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: _height * 0.025,
            horizontal: _width * 0.05,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: contactUsBorderColor),
            color: contactUsBgColor,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    height: 145.0,
                    width: 210.0,
                    child: Image(
                      image: AssetImage('assets/images/contact_us/office.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: _height * 0.01),
              Center(
                child: Text(
                  'YWCA offices are situated at the following centers',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat',
                    fontSize: 16.0,
                    height: 1,
                  ),
                ),
              ),
              SizedBox(height: _height * 0.015),
              centerCard(
                titlesOffice[0],
                addressesOffice[0],
                emailIdsOffice[0],
                contactNosOffice[0],
                phoneNo2: contactNosOffice[1],
              ),
              SizedBox(height: _height * 0.015),
              centerCard(
                titlesOffice[1],
                addressesOffice[1],
                emailIdsOffice[1],
                contactNosOffice[2],
              ),
              SizedBox(height: _height * 0.015),
              centerCard(
                titlesOffice[2],
                addressesOffice[2],
                emailIdsOffice[2],
                contactNosOffice[3],
                phoneNo2: contactNosOffice[4],
              ),
              SizedBox(height: _height * 0.015),
              centerCard(
                titlesOffice[3],
                addressesOffice[3],
                emailIdsOffice[3],
                contactNosOffice[5],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget hostelsTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: _height * 0.025,
            horizontal: _width * 0.05,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: contactUsBorderColor),
            color: contactUsBgColor,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    height: 145.0,
                    width: 210.0,
                    child: Image(
                      image: AssetImage('assets/images/contact_us/hostel.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: _height * 0.01),
              Center(
                child: Text(
                  'YWCA hostels are situated at the following centers',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat',
                    fontSize: 16.0,
                    height: 1,
                  ),
                ),
              ),
              SizedBox(height: _height * 0.015),
              centerCard(
                titlesHostel[0],
                addressesHostel[0],
                emailIdsHostel[0],
                contactNosHostel[0],
              ),
              SizedBox(height: _height * 0.015),
              centerCard(
                titlesHostel[1],
                addressesHostel[1],
                emailIdsHostel[1],
                contactNosHostel[1],
              ),
              SizedBox(height: _height * 0.015),
              centerCard(
                titlesHostel[2],
                addressesHostel[2],
                emailIdsHostel[2],
                contactNosHostel[2],
              ),
              SizedBox(height: _height * 0.015),
              centerCard(
                titlesHostel[3],
                addressesHostel[3],
                emailIdsHostel[3],
                contactNosHostel[2],
                emailId2: emailIdsHostel[4],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget guestHousesTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: _height * 0.025,
            horizontal: _width * 0.05,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: contactUsBorderColor),
            color: contactUsBgColor,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    height: 145.0,
                    width: 210.0,
                    child: Image(
                      image: AssetImage('assets/images/contact_us/office.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: _height * 0.01),
              Center(
                child: Text(
                  'YWCA guest houses are situated at the following centers',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    height: 1,
                  ),
                ),
              ),
              SizedBox(height: _height * 0.015),
              centerCard(
                titlesGuestHouse[0],
                addressesGuestHouse[0],
                emailIdsGuestHouse[0],
                contactNosGuestHouse[0],
              ),
              SizedBox(height: _height * 0.015),
              centerCard(
                titlesGuestHouse[1],
                addressesGuestHouse[1],
                emailIdsGuestHouse[1],
                contactNosGuestHouse[1],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
