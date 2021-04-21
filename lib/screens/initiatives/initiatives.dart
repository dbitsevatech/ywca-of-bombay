import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import 'piya.dart';
import 'customclip_path.dart';

// ignore: must_be_immutable
class Initiatives extends KFDrawerContent {
  @override
  _InitiativesState createState() => _InitiativesState();
}

class _InitiativesState extends State<Initiatives> {
  @override
  Widget build(BuildContext context) {
    // final _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            Stack(
              // circle design
              children: <Widget>[
                Positioned(
                  child: Image.asset("assets/images/circle-design.png"),
                ),
                Positioned(
                  child: AppBar(
                    centerTitle: true,
                    title: Text("YWCA Of Bombay",
                        style: TextStyle(
                            fontFamily: 'LilyScriptOne',
                            fontSize: 18.0,
                            color: Colors.black87)),
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
                        SizedBox(height: 100),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText2,
                            children: [
                              TextSpan(
                                text: 'Initiatives ',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  letterSpacing: 1,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      //padding: EdgeInsets.all(5.0),
                      height: 400,
                      width: 300,
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Piya(),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 50),
                              padding: EdgeInsets.only(right: 100.0),
                              width: 300.0,
                              height: 100.0,
                              child: ClipPath(
                                child: Container(
                                  width: 300.0,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 20, 50, 20),
                                    child: Text(
                                      "PIYA",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  // color: Colors.yellow,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      stops: [0.2, 1],
                                      colors: [
                                        Colors.blue[600],
                                        Colors.lightBlue[50]
                                      ],
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                                clipper: CustomClipPath(),
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/initiatives/img1.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 2,
                                    offset: Offset(
                                        5, 5), //changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //INITIATIVE NO 2
                          //Initiative(Asha Kiran Guest House),
                          //
                          //INITIATIVE NO 3
                          //Initiative(PASI),
                          //
                          //INITIATIVE NO 4
                          //
                          //INITIATIVE NO  5
                          //
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
