import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../widgets/blue_bubble_design.dart';

//DONE
// ignore: must_be_immutable
class AshaKiran extends StatelessWidget {
  final imageList = [
    'assets/images/initiatives/img1.jpg',
    'assets/images/initiatives/img2.jpg',
    'assets/images/initiatives/img3.jpg',
    'assets/images/initiatives/img4.jpg',
    'assets/images/initiatives/img5.jpg',
    'assets/images/initiatives/img6.jpg',
    'assets/images/initiatives/img7.jpg',
  ];

  final titles = [
    "Annual Day",
    "Sports Day",
    "Training of Puppeteers",
    "Workshop on Muslim Legal Rights",
    "Cartoon Making Workshop",
    "Self Defence Training",
    "Annual Day Celebration",
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
                  child: DetailPageBlueBubbleDesign(),
                ),
              ],
            ),

            Padding(padding: const EdgeInsets.only(top: 10)),
            Container(
              height: 300,
              child: Swiper(
                autoplay: false,
                itemCount: 7,
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
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.grey,
                    activeColor: Color(0XFF80DEEA),
                    //  DotsIndicator(
                    // dotsCount: pageLength,
                    // position: currentIndexPage,
                    // dotsCount: pageLength,
                    // decorator: DotsDecorator()
                  ),
                ),
              ),
            ),

//
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Asha Kiran Guest House',
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
                //overflow: TextOverflow.fade,
                "Asha Kiran, the women's development complex at Andheri continues to be a ray of hope to all its beneficiaries. It is dedicated to the all-round development of women and children of different backgrounds, age group, cultures, castes and creeds. It caters to the rapidly changing needs by providing a home away from home for Senior Citizens and Guests, to organizing awareness programmes, vocational courses, study centers, a day care center for senior citizens from the community, a crèche for children of domestic workers, and a shelter for women in distress. It also has an Amphitheatre and a hall facility.",
                maxLines: 8,
                style: TextStyle(
                    fontSize: 15,
                    color: textColor,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Rac ingSansOne'),
                //textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
