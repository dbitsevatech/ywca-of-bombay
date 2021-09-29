import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './admin/events/admin_events.dart';
import './edit_profile.dart';
import './events/user_events.dart';

import '../widgets/blue_bubble_design.dart';
import '../widgets/constants.dart';
import '../widgets/gradient_button.dart';
import '../models/User.dart';

class ViewProfileScreen extends StatefulWidget {
  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  var userInfo;
  final DrawerScaffoldController controller = DrawerScaffoldController();

  @override
  void initState() {
    userInfo = Provider.of<UserData>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    var firstName = userInfo.getfirstName;
    var lastName = userInfo.getlastName;
    var phoneNumber = userInfo.getphoneNumber;
    var emailId = userInfo.getemailId;
    var dateOfBirth = DateFormat('dd-MM-yyyy').format(userInfo.getdateOfBirth);
    var gender = userInfo.getgender;
    var nearestCenter = userInfo.getnearestCenter;
    var placeOfWork = userInfo.getplaceOfWork;
    var profession = userInfo.getprofession;
    var interestInMembership = userInfo.getinterestInMembership;
    var address = userInfo.getaddress;
    var role = userInfo.getmemberRole;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        if (role == "Admin") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminEvents()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Events()));
                        }
                      },
                    ),
                  ),
                ),
                PreferredSize(
                  preferredSize: Size.fromHeight(90),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        // Distance from ywca
                        // or else it will overlap
                        SizedBox(height: 90),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText2,
                            children: [
                              TextSpan(
                                text: 'YOUR PROFILE',
                                style: TextStyle(
                                  fontSize: 32,
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
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      left: _width * 0.05, right: _width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: _height * 0.03),
                      //greetings
                      Text(
                        'Hello $firstName, thanks for submitting your info!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: _height * 0.02),
                      if (role != "Staff") ...[
                        Text(
                          'You can choose to edit this information by clicking the button at the bottom.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                      SizedBox(height: _height * 0.04),
                      //main_body
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name = firstName + lastName
                            DetailText(text: 'Name: $firstName $lastName'),
                            SizedBox(height: 15),
                            // Phone
                            DetailText(text: 'Phone number: +91 $phoneNumber'),
                            SizedBox(height: 15),
                            // Email id
                            DetailText(text: 'Email ID: $emailId'),
                            SizedBox(height: 15),
                            // Address
                            DetailText(text: 'Address: $address'),
                            SizedBox(height: 15),
                            // Date of birth
                            DetailText(text: 'Date Of Birth: $dateOfBirth'),
                            SizedBox(height: 15),
                            // Gender
                            DetailText(text: 'Gender: $gender'),
                            SizedBox(height: 15),
                            // Nearest center
                            DetailText(
                                text: 'Nearest YWCA Centre: $nearestCenter'),
                            SizedBox(height: 15),
                            // Place of work/school/college
                            DetailText(
                                text: 'Institute/Organization: $placeOfWork'),
                            SizedBox(height: 15),
                            // Profession
                            DetailText(text: 'Profession: $profession'),
                            SizedBox(height: 15),
                            // Interest in membership
                            if (role != "Member")
                              DetailText(
                                  text:
                                      'Interested in being a member: $interestInMembership'),
                          ],
                        ),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                          color: Color(0x1A49DEE8),
                        ),
                      ),
                      SizedBox(height: _height * 0.02),
                      if (role == "Staff") ...[
                        Text(
                          'Kindly contact the admin if you wish to make changes to your profile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                      if (role == "Member") ...[
                        Text(
                          'Kindly contact the admin for approval AFTER you make changes to your profile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                      SizedBox(height: _height * 0.02),
                      if (role != "Staff") ...[
                        GradientButton(
                          buttonText: 'Edit Profile',
                          screenHeight: _height,
                          onPressedFunction: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfileScreen()));
                          },
                        )
                      ],
                      SizedBox(height: _height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailText extends StatelessWidget {
  final String text;
  DetailText({required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: Color(0xff333333),
        fontFamily: 'Montserrat',
      ),
    );
  }
}
