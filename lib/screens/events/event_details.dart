import 'package:ywcaofbombay/widgets/carousel.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  int _current = 0;
  var _opacity = 1.0;
  var _xOffset = 1.0;
  var _yOffset = 0.0;
  var _blurRadius = 0.0;
  Color btnColor = Color(0xFF00bbe4);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // TODO: Make the back-button black color
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.black,
              ),
              onPressed: () {
                //do something
                // gotoSecondActivity(context);
              },
            ),
          ],
        ),
        body: Column(children: <Widget>[
          Row(
            //ROW 1
            children: [
              Container(
                color: Colors.orange,
                // margin: EdgeInsets.all(0.0),
                child: CustomPaint(
                  painter: OpenPainter(),
                ),
              ),
            ],
          ),
          Row(//ROW 2
              children: [
            Container(
              // color: Colors.orange,
              margin: EdgeInsets.fromLTRB(300.0, 0.0, 0.0, 0.0),
              child: RaisedButton(
                onPressed: () {},
                color: Color(0xFF00bbe4),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Member",
                  style: new TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ]),
          // Row(// ROW 3
          //     children: [
          //   Container(
          //     color: Colors.orange,
          //     margin: EdgeInsets.all(25.0),
          //     child: FlutterLogo(
          //       size: 60.0,
          //     ),
          //   ),
          // ]),
          SizedBox(height: 5),
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  // setState(() {
                  //   _current = index;
                  // });
                }),
          ),
          // Sliding dots
          Row(
            // Row 3
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
          Row(
            //ROW 4
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(45.0, 10.0, 0.0, 0.0),
                child: Text(
                  "Christmas Decor Workshop",
                  style: new TextStyle(
                      fontSize: 22.0,
                      color: Colors.black87,
                      shadows: [
                        Shadow(
                          color: Colors.blue.shade900.withOpacity(_opacity),
                          offset: Offset(_xOffset, _yOffset),
                          blurRadius: _blurRadius,
                        ),
                      ],
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            //ROW 5
            children: [
              Container(
                width: 350,
                margin: EdgeInsets.fromLTRB(45.0, 10.0, 0.0, 0.0),
                child: Text(
                  "Christmas Decorations don't have to be complicated to be elegant. We're sharing our favorite easy DIY Christmas decor ideas and tricks.",
                  style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          Row(
            //ROW 6
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(45.0, 10.0, 0.0, 0.0),
                child: Text(
                  "Resource Person: Sharon Pires",
                  style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          Row(
            //ROW 7
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(45.0, 10.0, 0.0, 0.0),
                child: Text(
                  "Venue: Online",
                  style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          Row(
            //ROW 8
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(45.0, 10.0, 0.0, 0.0),
                child: Text(
                  "Amount : Free",
                  style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          Row(
            //ROW 9
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(45.0, 10.0, 0.0, 0.0),
                child: Text(
                  "Date : 19/12/2020",
                  style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          Row(
            //ROW 10
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(45.0, 10.0, 0.0, 0.0),
                child: Text(
                  "Time : 11:00 AM",
                  style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ]));
  }
}

goBackToPreviousScreen(BuildContext context) {
  Navigator.pop(context);
}

// gotoSecondActivity(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => CarouselDemo()),
//   );
// }

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff49DEE8).withOpacity(0.5)
      ..style = PaintingStyle.fill;
    //a circle
    canvas.drawCircle(Offset(-40, -20), 100, paint1);
    canvas.drawCircle(Offset(60, -100), 100, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
