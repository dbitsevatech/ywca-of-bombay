import 'package:flutter/material.dart';

import '../screens/initiatives/customclip_path.dart';

class Initiative extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Piya()));
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
              padding: EdgeInsets.fromLTRB(10, 20, 50, 20),
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  stops: [0.2, 1],
                  colors: [Colors.blue[600], Colors.lightBlue[50]]),
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
            image: AssetImage('assets/images/initiatives/img1.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 2,
              offset: Offset(5, 5), //changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
