import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../../widgets/blue_bubble_design.dart';
import '../../widgets/constants.dart';

// ignore: must_be_immutable
class ContactUs extends KFDrawerContent {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      ),
                      onPressed: widget.onMenuPressed,
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
                                  fontSize: 22,
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
            Expanded(
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text('Contact us'),
              //   ],
              // ),
              // child: DefaultTabController(
              //   length: 3,
              //   child: Scaffold(
              //     appBar: AppBar(
              //       bottom: TabBar(
              //         tabs: [
              //           Tab(text: "OFFICES"),
              //           Tab(text: "HOSTELS"),
              //           Tab(text: "GUEST HOUSES"),
              //         ],
              //       ),
              //       title: Text(''),
              //     ),
              //     body: TabBarView(
              //       children: [
              //         Center(),
              //         Center(),
              //         Center(),
              //       ],
              //     ),
              //   ),
              // ),
              child: DefaultTabController(
                length: 3,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    // title: Text(''),
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(10),
                      child: Container(
                        child: TabBar(
                          labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelColor: Colors.black54,
                          labelColor: Colors.black,
                          indicatorColor: secondaryColor,
                          automaticIndicatorColorAdjustment: true,
                          tabs: [
                            Container(
                              height: 20.0,
                              width: 55.0,
                              child: Tab(text: 'OFFICES'),
                            ),
                            Container(
                              height: 20.0,
                              width: 55.0,
                              child: Tab(text: 'HOSTELS'),
                            ),
                            Container(
                              height: 20.0,
                              width: 100.0,
                              child: Tab(text: 'GUEST HOUSES'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Container(
                            color: contactUsBgColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      height: 145.0,
                                      width: 210.0,
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/contact_us/office.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'YWCA offices are situated at the following centers',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'CM Sans Serif',
                                      fontSize: 20.0,
                                      height: 1,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: contactUsCardColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    height: 130,
                                    width: 300,
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: "ANDHERI \n ",
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          fontFamily: 'CM Sans Serif',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                ' Asha Kiran,\n 53,J.P. Road,\nAndheri (W)\n Mumbai-400058\n Email:ywcaandheri@rediffmail.com\n Ph:022-26702831 / 022-26702872',
                                            style: TextStyle(
                                              fontFamily: 'CM Sans Serif',
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.5,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: contactUsCardColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    height: 130,
                                    width: 300,
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: "BELAPUR \n ",
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          fontFamily: 'CM Sans Serif',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                ' Anugraha Hostel,\n Sector 8 ,\n CBD-Belapur \n Navi Mumbai-400614\n Email:ywcabelapur@gmail.com\n Ph:022-27570786',
                                            style: TextStyle(
                                              fontFamily: 'CM Sans Serif',
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.5,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: contactUsCardColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    height: 130,
                                    width: 300,
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: "BYCULLA \n ",
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          fontFamily: 'CM Sans Serif',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                ' 75 , Motlibai Street ,\n Near Maratha Mandir \n  Mumbai-400008\n Email:ybombaygs@gmail.com\n Ph:022-23096544 / 022-23096555 / 022-23020469',
                                            style: TextStyle(
                                              fontFamily: 'CM Sans Serif',
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.5,
                                            ),
                                          )
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
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'HOSTELS',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'CM Sans Serif',
                                    fontSize: 26.0,
                                    height: 1,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              SizedBox(height: 20.0),
                              Center(
                                child: Text(
                                  'YWCA hostels are situated at the following centers',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'CM Sans Serif',
                                    fontSize: 20.0,
                                    height: 1,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: contactUsCardColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  height: 130,
                                  width: 300,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "DIPTI DAMAN HOSTEL  \n ",
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        fontFamily: 'CM Sans Serif',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              ' Asha Kiran,\n 53,J.P. Road,\nAndheri (W)\n Mumbai-400058\n Email:ywcaandheri@rediffmail.com\n Ph:022-26702831 / 022-26702872',
                                          style: TextStyle(
                                            fontFamily: 'CM Sans Serif',
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.5,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: contactUsCardColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  height: 130,
                                  width: 300,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "ANUGRAHA HOSTEL \n ",
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        fontFamily: 'CM Sans Serif',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              ' Anugraha Hostel,\n Sector 8 ,\n CBD-Belapur \n Navi Mumbai-400614\n Email:ywcabelapur@gmail.com\n Ph:022-27570786',
                                          style: TextStyle(
                                            fontFamily: 'CM Sans Serif',
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.5,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: contactUsCardColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  height: 130,
                                  width: 300,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "ACHAMMA BHAVAN HOSTEL \n ",
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        fontFamily: 'CM Sans Serif',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              ' 75 , Motlibai Street ,\n Near Maratha Mandir \n  Mumbai-400008\n Email:ybombaygs@gmail.com\n Ph:022-23096544 / 022-23096555 / 022-23020469',
                                          style: TextStyle(
                                            fontFamily: 'CM Sans Serif',
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.5,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'GUEST HOUSES',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'CM Sans Serif',
                                    fontSize: 26.0,
                                    height: 1,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Center(
                                child: Container(
                                  child: Center(),
                                ),
                              ),
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    height: 180.0,
                                    width: 250.0,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/contact_us/hostel.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Center(
                                child: Text(
                                  'YWCA Guest houses are situated at the following centers',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'CM Sans Serif',
                                    fontSize: 20.0,
                                    height: 1,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: contactUsCardColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  height: 130,
                                  width: 300,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "ASHA KIRAN \n ",
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        fontFamily: 'CM Sans Serif',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              ' Asha Kiran,\n 53,J.P. Road,\nAndheri (W)\n Mumbai-400058\n Email:ywcaandheri@rediffmail.com\n Ph:022-26702831 / 022-26702872',
                                          style: TextStyle(
                                            fontFamily: 'CM Sans Serif',
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.5,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 50.0),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: contactUsCardColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  height: 130,
                                  width: 300,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "INTERNATIONAL CENTRE \n ",
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        fontFamily: 'CM Sans Serif',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              ' 18 , Madame Cama Road ,\n Fort, Mumbai - 400001 8 \n Email:ymcaic@mtnl.net.in\n Ph:022-22025053 / 022-66247222 / 022-2286814',
                                          style: TextStyle(
                                            fontFamily: 'CM Sans Serif',
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.5,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
