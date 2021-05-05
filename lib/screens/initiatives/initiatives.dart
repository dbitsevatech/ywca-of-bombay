import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import 'piya.dart';
import 'customclip_path.dart';
import 'initiative_card.dart';
import '../../models/initiative.dart';
import '../../widgets/blue_bubble_design.dart';

// ignore: must_be_immutable
class Initiatives extends KFDrawerContent {
  @override
  _InitiativesState createState() => _InitiativesState();
}

class _InitiativesState extends State<Initiatives> {
  final List<Initiative> _allInitiatives = Initiative.allInitiatives();
  @override
  Widget build(BuildContext context) {
    // final _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            Stack(
              // circle design
              children: <Widget>[
                MainPageBlueBubbleDesign(),
                Positioned(
                  child: AppBar(
                    centerTitle: true,
                    title: Text(
                      "YWCA Of Bombay",
                      style: TextStyle(
                        fontFamily: 'LilyScriptOne',
                        fontSize: 18.0,
                        color: Colors.black87,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: widget.onMenuPressed,
                    ),
                  ),
                ),
                PreferredSize(
                  preferredSize: Size.fromHeight(100),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        // Distance from ywca
                        // or else it will overlap
                        SizedBox(height: 100),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText2,
                            children: [
                              TextSpan(
                                text: 'Initiatives ',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 25),
                    InitiativeCard(
                      name: "PIYA",
                      image: "img1.jpg",
                      gradientColor: Colors.blue[600],
                      route: "asha-kiran",
                    ),
                    InitiativeCard(
                      name: "Asha Kiran Guest House",
                      image: "img2.jpg",
                      gradientColor: Colors.yellow[600],
                      route: "asha-kiran",
                    ),
                    InitiativeCard(
                      name: "PASI",
                      image: "img3.jpg",
                      gradientColor: Colors.red[600],
                      route: "pasi",
                    ),
                    InitiativeCard(
                      name: "Hostels",
                      image: "img4.jpg",
                      gradientColor: Colors.green[600],
                      route: "hostels",
                    ),
                    InitiativeCard(
                      name: "Hostels",
                      image: "img4.jpg",
                      gradientColor: Colors.blue[600],
                      route: "hostels",
                    ),
                    getHomePageBody(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getAllInitiatives(BuildContext context) {
    // pass array of all properties here
  }

  Widget _getInitiativeCard(BuildContext context, int index) {
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
                  _allInitiatives[index].name,
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
            clipper: CustomClipPath(),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/initiatives/' + _allInitiatives[index].image),
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
