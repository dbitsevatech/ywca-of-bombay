import 'package:auth/screens/initiatives/piya.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import 'package:auth/screens/initiatives/customclip_path.dart';

// ignore: must_be_immutable
class Initiatives extends KFDrawerContent {
  @override
  _InitiativesState createState() => _InitiativesState();
}

class _InitiativesState extends State<Initiatives> {
  @override
  Widget build(BuildContext context) {
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
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        child: Material(
                          shadowColor: Colors.transparent,
                          color: Colors.transparent,
                          child: IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.black,
                            ),
                            onPressed: widget.onMenuPressed,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(width: 15)
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Text('Initiatives'),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Initiatives',
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RacingSansOne'),
                    ),
                  ),
                  //

                  Center(
                    child: Container(
                      //padding: EdgeInsets.all(5.0),
                      height: 400,
                      width: 300,
                      child: Column(children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Piya()));
                          },
//
//
//
                          child: Container(
                            margin: EdgeInsets.only(top: 50),
                            padding: EdgeInsets.only(right: 100.0),
                            width: 300.0,
                            height: 100.0,
                            //
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
                                  decoration: new BoxDecoration(
                                    gradient: LinearGradient(stops: [
                                      0.2,
                                      1
                                    ], colors: [
                                      Colors.blue[600],
                                      Colors.lightBlue[50]
                                    ]),
                                    borderRadius: new BorderRadius.only(
                                      topLeft: new Radius.circular(20.0),
                                      bottomLeft: new Radius.circular(20.0),
                                    ),
                                  )),
                              clipper: CustomClipPath(),
                            ),
                            //
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage(
                                    'assets/images/initiatives/img1.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 2,
                                  offset:
                                      Offset(5, 5), //changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     print("tapped on container 2");
                        //   },
//
//
//
                        Container(
                          // padding: EdgeInsets.all(5.0),
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(right: 100.0),
                          width: 300.0,
                          height: 100.0,
                          //
                          //children: [
                          //   child: ClipPath(
                          //   child: Container(
                          //     width: MediaQuery.of(context).size.width,
                          //     color: Colors.yellow,
                          //   ),
                          //   clipper: CustomClipPath(),
                          // ),
                          // //

                          child: ClipPath(
                            child: Container(
                                width: 300.0,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 50, 5),
                                  child: Text(
                                    "Asha Kiran Guest House",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // color: Colors.yellow,
                                decoration: new BoxDecoration(
                                  gradient: LinearGradient(stops: [
                                    0.2,
                                    1
                                  ], colors: [
                                    Colors.amber[400],
                                    Colors.amber[50]
                                  ]),
                                  borderRadius: new BorderRadius.only(
                                    topLeft: new Radius.circular(20.0),
                                    bottomLeft: new Radius.circular(20.0),
                                  ),
                                )),
                            clipper: CustomClipPath(),
                          ),
                          //]
                          //
                          decoration: new BoxDecoration(
                            //color: const Color(0xFFD81B60),
                            image: new DecorationImage(
                              image: new AssetImage(
                                  'assets/images/initiatives/img2.jpg'),
                              fit: BoxFit.cover,
                            ),

                            borderRadius:
                                new BorderRadius.all(new Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 2,
                                offset:
                                    Offset(5, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          //margin: EdgeInsets.all(5),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     print("tapped on container 3");
                        //   },
//
//
//
                        Container(
                          //padding: EdgeInsets.all(5.0),
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(right: 100.0),
                          // width: 300.0,
                          height: 100.0,
                          //
                          //
                          child: ClipPath(
                            child: Container(
                              width: 300.0,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 50, 20),
                                child: Text(
                                  "PASI",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // color: Colors.yellow,
                              decoration: new BoxDecoration(
                                gradient: LinearGradient(stops: [
                                  0.2,
                                  1
                                ], colors: [
                                  Colors.pink[300],
                                  Colors.orange[300]
                                ]),
                                borderRadius: new BorderRadius.only(
                                  topLeft: new Radius.circular(20.0),
                                  bottomLeft: new Radius.circular(20.0),
                                ),
                              ),
                            ),
                            clipper: CustomClipPath(),
                          ),
                          //
                          //
                          // child: Container(
                          //   width: 150,
                          //   child: Text(
                          //     "Nigel",
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //       fontSize: 25,
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          //   // color: Colors.purple,
                          //   decoration: new BoxDecoration(
                          //     color: Colors.purple,
                          //     borderRadius: new BorderRadius.only(
                          //       topLeft: new Radius.circular(20.0),
                          //       bottomLeft: new Radius.circular(20.0),
                          //     ),
                          //   ),
                          // ),
                          decoration: new BoxDecoration(
                            //color: const Color(0xFFD81B60),
                            image: new DecorationImage(
                              image: new AssetImage(
                                  'assets/images/initiatives/img3.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 2,
                                offset:
                                    Offset(5, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          //margin: EdgeInsets.all(5),
                        ),
                      ]),
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
