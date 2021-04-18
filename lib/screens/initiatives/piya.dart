import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../widgets/open_painter.dart';

class Piya extends StatelessWidget {
  final imageList = [
    'assets/images/initiatives/img1.jpg',
    'assets/images/initiatives/img2.jpg',
    'assets/images/initiatives/img3.jpg',
    'assets/images/initiatives/img4.png',
  ];

  final textColor = const Color(0xff333333);
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
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
            Padding(padding: const EdgeInsets.only(top: 10)),
            Container(
              height: 300,
              child: Swiper(
                autoplay: false,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      // image: AssetImage(images1[index]),
                      image: AssetImage(imageList[index]),
                      // image: AssetImage("assets/images/img2.jpg"),
                      fit: BoxFit.contain,
                    ),
                  );
                },
                viewportFraction: 0.8,
                scale: 0.9,
                pagination: SwiperPagination(),
              ),
            ),
//
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'PIYA- Participation and involvement of youth in action',
                style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RacingSansOne'),
                textAlign: TextAlign.center,
              ),
            ),
//
            Container(
              width: 300,
              //Expanded(
              child: Text(
                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.''',
                //overflow: TextOverflow.fade,
                maxLines: 8,
                style: TextStyle(
                    fontSize: 15,
                    color: textColor,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'RacingSansOne'),
                //textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
