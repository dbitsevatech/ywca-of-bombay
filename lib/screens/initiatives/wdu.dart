import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../widgets/open_painter.dart';

//DONE
// ignore: must_be_immutable
class Wdu extends StatelessWidget {
  final imageList = [
    'assets/images/initiatives/img1.jpg',
    'assets/images/initiatives/img2.jpg',
    'assets/images/initiatives/img3.jpg',
    'assets/images/initiatives/img4.jpg',
    'assets/images/initiatives/img5.jpg',
    'assets/images/initiatives/img6.jpg',
    'assets/images/initiatives/img7.jpg',
    'assets/images/initiatives/img8.jpg',
    'assets/images/initiatives/img9.jpg',
    'assets/images/initiatives/img10.jpg',
    'assets/images/initiatives/img11.jpg',
    'assets/images/initiatives/img12.jpg',
  ];

  final titles = [
    "Nutritious food Competition",
    "Children's Programme ",
    "Bakery certificate distribution",
    "Debate Competition",
    "Bakery Practical",
    "Rally on Human Rights Awareness",
    "Annual Sports Day Celebration",
    "Bunny Tamtola",
    "Peace March",
    "Children's Camp",
    "Disaster Management Training",
    "Anand Mela",
  ];

  // static var decorator = DotsDecorator(
  //   activeColor: Colors.red,
  //   activeSize: Size.square(50.0),
  //   activeShape: RoundedRectangleBorder(),
  // );

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
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    // To centralize the children.
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: AssetImage(imageList[index]),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        titles[index],
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff333333),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RacingSansOne'),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
                viewportFraction: 0.8,
                scale: 0.9,
                pagination: SwiperPagination(
                  //changing the color of the pagination dots and that of
                  //the active dot
                  builder: new DotSwiperPaginationBuilder(
                    color: Colors.grey,
                    activeColor: Color(0XFF80DEEA),
                  ),
                ),
              ),
            ),

//
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text(
                "WDU-Women's Development Unit",
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
                // '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.''',
                "Women's Development (WDU) promotes all round well being of women and children. This is actually achieved through community development programs, vocational training courses, sustainability projects, capacity building activities and awareness programs. Aasra is a family counseling center which supports women in need.",
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
