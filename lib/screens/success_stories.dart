import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

// ignore: must_be_immutable
class SuccessStories extends KFDrawerContent {
  @override
  _SuccessStoriesState createState() => _SuccessStoriesState();
}

class _SuccessStoriesState extends State<SuccessStories> {
  Container cardWid(String title) {
    return //  card start
        Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFCDF1EF)),
          color: Color(0xFFCDF1EF),
          borderRadius: BorderRadius.all(Radius.circular(40))),
      height: 500,
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //image
          Container(
            margin: EdgeInsets.all(30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(120.0),
              child: Image.network(
                'https://picsum.photos/250?image=9',
                height: 150.0,
                width: 150.0,
              ),
            ),
          ),
          //  image end
          //  card Title
          Text(
            title,
            // 'A Slice Of Support',
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          //  card Title
          //card info
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Text(
              'Shweta was a very clever girl but the conditons at home were very poor ' +
                  'Shweta was a very clever girl but the conditons at home were very poor ' +
                  'Shweta was a very clever girl but the conditons at home were very poor ' +
                  'Shweta was a very clever girl but the conditons at home were very poor ' +
                  'Shweta was a very clever girl but the conditons at home were very poor ' +
                  'Shweta was a very clever girl but the conditons at home were very poor ',
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
          ),
          //  end card info
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final PageController ctrl = PageController();
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
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text('Success Stories'),
              //   ],
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //Title start
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    // color:Colors.red,
                    child: Center(
                      child: Text(
                        'Success Stories',
                        style: TextStyle(
                            color: Color(0xff333647),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                  ),
                  //Title end
                  Container(
                    height: height * 0.75,
                    // color: Colors.red,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: ctrl,
                      children: <Widget>[
                        cardWid("Page 1"),
                        cardWid("Page 2"),
                        cardWid("Page 3"),
                      ],
                    ),
                  ),
                  // cardWid("teat"),
                  // cardWid("teat"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
