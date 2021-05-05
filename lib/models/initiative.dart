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
        color: Colors.blue,
        route: "piya",
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "Asha Kiran Guest House",
        image: "img2.jpg",
        color: Colors.yellow,
        route: "asha-kiran",
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "PASI",
        image: "img3.jpg",
        color: Colors.red,
        route: "pasi",
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "General",
        image: "img4.jpg",
        color: Colors.green,
        route: "general",
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "WDU",
        image: "img1.jpg",
        color: Colors.purple,
        route: "wdu",
      ),
    );
    return listOfInitiatives;
  }
}
