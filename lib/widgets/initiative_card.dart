import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../models/Initiative.dart';
// import '../screens/initiatives/piya.dart';
import '../screens/initiatives/initiative_details.dart';

final List<Initiative> _allInitiatives = Initiative.allInitiatives();

Widget buildInitiativeCard(BuildContext context, int index) {
  final _height = MediaQuery.of(context).size.height;
  final _width = MediaQuery.of(context).size.width;



  return Container(
    padding: EdgeInsets.only(bottom: _height * 0.02, left: 50, right: 50),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) => Piya()),
              MaterialPageRoute(
                builder: (context) => InitiativeDetails(
                  _allInitiatives[index].title,
                  _allInitiatives[index].description,
                  _allInitiatives[index].imagePathList,
                  _allInitiatives[index].imageTitleList,
                ),
              ));
        },
        child: Container(
          padding: EdgeInsets.only(right: 100.0),
          height: 100,
          // height: _height * 0.11,
          // text part
          child: ClipPath(
            child: Container(
              alignment: Alignment.center,
              width: 300.0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 60, 20),
                child: AutoSizeText(
                  _allInitiatives[index].name,
                  // "PIYA",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.2, 1],
                  colors: [
                    _allInitiatives[index].color,
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
              ),
            ),
            clipper: CustomClipPath(
              screenHeight: _height,
              screenWidth: _width,
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_allInitiatives[index].image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                offset: Offset(5, 5), //changes position of shadow
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  double screenHeight;
  double screenWidth;

  CustomClipPath({
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  // Path getClip(Size size) {
  //   Path path = Path();
  //   // path.lineTo(0, screenHeight * 0.11); // bottom-left co-ordinates
  //   path.lineTo(0, 100); // bottom-left co-ordinates
  //   // path.lineTo(140, screenHeight * 0.11); // bottom-right co-ordinates
  //   path.lineTo(140, 100); // bottom-right co-ordinates
  //   path.lineTo(170, 0); // top-right co-ordinates
  //   return path;
  // }

  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width - (size.width * 0.3), size.height);
    path.lineTo(size.width - (size.width * 0.075), 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
