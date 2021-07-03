import 'package:flutter/material.dart';

class Initiative {
  // FOR INITIATIVES LIST PAGE
  //--- Name Of Initiative
  final String name;
  //--- imagename.extension for card image
  final String image;
  //--- card color
  final Color color;
  //--- route to initiative detail page
  final String route;

  // FOR INITIATIVE DETAILS PAGE
  //--- Title of Initiative
  final String title;
  //--- Description of initiative
  final String description;
  //--- List of image paths for Initiative
  final List<String> imageList;

  Initiative({
    this.name,
    this.image,
    this.color,
    this.route,
    this.title,
    this.description,
    this.imageList,
  });

  static List<Initiative> allInitiatives() {
    List<Initiative> listOfInitiatives = [];

    listOfInitiatives.add(
      Initiative(
        name: "PIYA",
        image: "img1.jpg",
        color: Colors.blue[700],
        route: "piya",
        title: "PIYA - P I Y A",
        description: "This is the PIYA's description",
        imageList: [
          'assets/images/initiatives/img1.jpg',
          'assets/images/initiatives/img2.jpg',
          'assets/images/initiatives/img3.jpg',
          'assets/images/initiatives/img4.jpg',
          'assets/images/initiatives/img5.jpg',
          'assets/images/initiatives/img6.jpg',
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "Asha Kiran Guest House",
        image: "img2.jpg",
        color: Colors.yellow[700],
        route: "asha-kiran",
        title: "ASHA KIRAN",
        description: "This is the Asha Kiran's description",
        imageList: [
          'assets/images/initiatives/img1.jpg',
          'assets/images/initiatives/img2.jpg',
          'assets/images/initiatives/img3.jpg',
          'assets/images/initiatives/img4.jpg',
          'assets/images/initiatives/img5.jpg',
          'assets/images/initiatives/img6.jpg',
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "PASI",
        image: "img3.jpg",
        color: Colors.red[700],
        route: "pasi",
        title: "PASI",
        description: "This is the PASI's description",
        imageList: [
          'assets/images/initiatives/img1.jpg',
          'assets/images/initiatives/img2.jpg',
          'assets/images/initiatives/img3.jpg',
          'assets/images/initiatives/img4.jpg',
          'assets/images/initiatives/img5.jpg',
          'assets/images/initiatives/img6.jpg',
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "WDU",
        image: "img4.jpg",
        color: Colors.green[700],
        route: "general",
        title: "WDU",
        description: "This is the WDUs description",
        imageList: [
          'assets/images/initiatives/img1.jpg',
          'assets/images/initiatives/img2.jpg',
          'assets/images/initiatives/img3.jpg',
          'assets/images/initiatives/img4.jpg',
          'assets/images/initiatives/img5.jpg',
          'assets/images/initiatives/img6.jpg',
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "YWCA Hostels",
        image: "img1.jpg",
        color: Colors.deepOrange,
        route: "piya",
        title: "YWCA Hostels",
        description: "This is the Hostels description",
        imageList: [
          'assets/images/initiatives/img1.jpg',
          'assets/images/initiatives/img2.jpg',
          'assets/images/initiatives/img3.jpg',
          'assets/images/initiatives/img4.jpg',
          'assets/images/initiatives/img5.jpg',
          'assets/images/initiatives/img6.jpg',
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "Public Relations",
        image: "img2.jpg",
        color: Colors.deepPurple,
        route: "asha-kiran",
        title: "Public Relations",
        description: "This is the Public relations description",
        imageList: [
          'assets/images/initiatives/img1.jpg',
          'assets/images/initiatives/img2.jpg',
          'assets/images/initiatives/img3.jpg',
          'assets/images/initiatives/img4.jpg',
          'assets/images/initiatives/img5.jpg',
          'assets/images/initiatives/img6.jpg',
        ],
      ),
    );
    // listOfInitiatives.add(
    //   Initiative(
    //     name: "Shelter Homes",
    //     image: "img3.jpg",
    //     color: Colors.pink,
    //     route: "pasi",
    //   ),
    // );
    // listOfInitiatives.add(
    //   Initiative(
    //     name: "Membership",
    //     image: "img4.jpg",
    //     color: Colors.yellow[700],
    //     route: "general",
    //   ),
    // );
    // listOfInitiatives.add(
    //   Initiative(
    //     name: "International Center",
    //     image: "img1.jpg",
    //     color: Colors.blue[700],
    //     route: "piya",
    //   ),
    // );
    // listOfInitiatives.add(
    //   Initiative(
    //     name: "Spiritual Emphasis",
    //     image: "img2.jpg",
    //     color: Colors.green[700],
    //     route: "asha-kiran",
    //   ),
    // );
    // listOfInitiatives.add(
    //   Initiative(
    //     name: "General",
    //     image: "img3.jpg",
    //     color: Colors.deepPurple,
    //     route: "pasi",
    //   ),
    // );

    return listOfInitiatives;
  }
}
