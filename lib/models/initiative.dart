import 'package:flutter/material.dart';

class Initiative {
  //--- Name Of Initiative
  final String name;
  //--- imagename.extension for card image
  final String image;
  //--- card color
  final Color color;
  //--- route to initiative detail page
  final String route;

  Initiative({
    this.name,
    this.image,
    this.color,
    this.route,
  });

  static List<Initiative> allInitiatives() {
    List<Initiative> listOfInitiatives = [];

    listOfInitiatives.add(
      Initiative(
        name: "PIYA",
        image: "img1.jpg",
        color: Colors.blue[700],
        route: "piya",
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "Asha Kiran Guest House",
        image: "img2.jpg",
        color: Colors.yellow[700],
        route: "asha-kiran",
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "PASI",
        image: "img3.jpg",
        color: Colors.red[700],
        route: "pasi",
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "WDU",
        image: "img4.jpg",
        color: Colors.green[700],
        route: "general",
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "YWCA Hostels",
        image: "img1.jpg",
        color: Colors.deepOrange,
        route: "piya",
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "Public Relations",
        image: "img2.jpg",
        color: Colors.deepPurple,
        route: "asha-kiran",
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "Shelter Homes",
        image: "img3.jpg",
        color: Colors.pink,
        route: "pasi",
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "Membership",
        image: "img4.jpg",
        color: Colors.yellow[700],
        route: "general",
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "International Center",
        image: "img1.jpg",
        color: Colors.blue[700],
        route: "piya",
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "Spiritual Emphasis",
        image: "img2.jpg",
        color: Colors.green[700],
        route: "asha-kiran",
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "General",
        image: "img3.jpg",
        color: Colors.deepPurple,
        route: "pasi",
      ),
    );

    return listOfInitiatives;
  }
}
