import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../widgets/blue_bubble_design.dart';

class InitiativeDetails extends StatefulWidget {
  final String title;
  final String description;
  final List<String> imageList;

  const InitiativeDetails(this.title, this.description, this.imageList);

  @override
  _InitiativeDetailsState createState() =>
      _InitiativeDetailsState(title, description, imageList);
}

class _InitiativeDetailsState extends State<InitiativeDetails> {
  final String _title;
  final String _description;
  final List<String> _imageList;

  _InitiativeDetailsState(this._title, this._description, this._imageList);

  final imageList = [
    'assets/images/initiatives/img1.jpg',
    'assets/images/initiatives/img2.jpg',
    'assets/images/initiatives/img3.jpg',
    'assets/images/initiatives/img4.jpg',
    'assets/images/initiatives/img5.jpg',
    'assets/images/initiatives/img6.jpg',
  ];

  final titles = [
    "Walk for freedom",
    "Walkathon",
    "A trek to Kaldurg Fort",
    "Interschool competition",
    "Dance Therapy by Piya",
    "Piya",
  ];

  // static var decorator = DotsDecorator(
  //   activeColor: Colors.red,
  //   activeSize: Size.square(50.0),
  //   activeShape: RoundedRectangleBorder(),
  // );

  final textColor = const Color(0xff333333);
  @override
  Widget build(BuildContext context) {
    print("title: " + this._title);
    print("description: " + this._description);
    print("image list: " + this._imageList.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    color: Colors.orange,
                    // margin: EdgeInsets.all(0.0),
                    // child: CustomPaint(
                    //   painter: BlueBubbleDesign(),
                    // ),
                    child: DetailPageBlueBubbleDesign(),
                  ),
                ],
              ),

              Padding(padding: const EdgeInsets.only(top: 10)),
              Container(
                height: 300,
                child: Swiper(
                  autoplay: false,
                  itemCount: 6,
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
                            fontFamily: 'RacingSansOne',
                          ),
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
                    ),
                  ),
                ),
              ),

//
              Padding(
                padding: const EdgeInsets.only(top: 0),
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
                  // '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.''',
                  "Participation and Involvement of Youth in Action (PIYA) is committed to advocate for women’s rights, through the active participation and involvement of a diverse group of young women between the age of 18 to 30 years, who are potential leaders and are committed to social action and transformation of society.",
                  //overflow: TextOverflow.fade,
                  maxLines: 8,
                  style: TextStyle(
                    fontSize: 15,
                    color: textColor,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'RacingSansOne',
                  ),
                  //textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
