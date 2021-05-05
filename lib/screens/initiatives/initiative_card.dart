import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'customclip_path.dart';
import 'piya.dart';
import '../../models/initiative.dart';

class InitiativeCard extends StatelessWidget {
  final String name;
  final String image;
  final String route;
  final Color gradientColor;

  InitiativeCard({
    @required this.name,
    @required this.image,
    @required this.gradientColor,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Piya()),
          );
        },
        child: Container(
          padding: EdgeInsets.only(right: 100.0),
          width: 300.0,
          height: 100.0,
          child: ClipPath(
            child: Container(
              alignment: Alignment.center,
              width: 300.0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 60, 20),
                child: AutoSizeText(
                  name,
                  // "PIYA",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.2, 1],
                  colors: [
                    gradientColor,
                    Colors.white,
                  ],
                ),
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
              image: AssetImage('assets/images/initiatives/' + image),
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
      ),
    );
  }
}
