import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../widgets/constants.dart';

// ignore: must_be_immutable
class SuccessStories extends KFDrawerContent {
  @override
  _SuccessStoriesState createState() => _SuccessStoriesState();
}

class _SuccessStoriesState extends State<SuccessStories> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
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
                //Title start
                Padding(
                  padding: EdgeInsets.only(top: _height * 0.12),
                  child: Container(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Success Stories',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xff333647),
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                ),
                //Title end
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
                  Container(
                    height: _height * 0.7,
                    // color: Colors.red,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: ctrl,
                      children: <Widget>[
                        cardWid("A Slice of Support", _height, _width),
                        cardWid("A Stitch in Time", _height, _width),
                        cardWid("Beauty with Brains", _height, _width),
                        cardWid("Food For Thought", _height, _width),
                        cardWid("Hair Tales", _height, _width),
                        cardWid("Nursing Aid", _height, _width),
                        cardWid("Promoting Education", _height, _width),
                        cardWid("Aasra", _height, _width),
                      ],
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

  Container cardWid(String title, double _height, double _width) {
    print(_height);
    print(_width);
    //  card start
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _width * 0.08),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFCDF1EF)),
        color: successStoriesCardBgColor,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      height: 500,
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //    image
          Container(
            margin: EdgeInsets.all(_height * 0.025),
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(120.0),
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
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          //  card Title
          //card info
          Padding(
            padding: EdgeInsets.only(
              left: _width * 0.05,
              right: _width * 0.05,
              top: _height * 0.025,
            ),
            child: Text(
              'Shweta was a very clever girl but the conditons at home were very poor ' +
                  'Shweta was a very clever girl but the conditons at home were very poor ' +
                  'Shweta was a very clever girl but the conditons at home were very poor ' +
                  'Shweta was a very clever girl but the conditons at home were very poor ' +
                  'Shweta was a very clever girl but the conditons at home were very poor ' +
                  'Shweta was a very clever girl but the conditons at home were very poor ',
              // "Shweta Berde was a very clever girl but the conditions at home were very poor. Her father was a diabetic patient and he was not working. She wanted to join a bakery course from YWCA so that she could pursue her dreams but her father could not support her due to their financial problems. Our social worker made a home visit and then YWCA sponsored her for Cookery, Bakery and confectionery courses in the year 2017-18. Now she is working in 1441 Pizzeria.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
          //  end card info
        ],
      ),
    );
  }
}
